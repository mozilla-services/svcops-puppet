import os
from os.path import join as pjoin

import fabdeploytools.envs
from fabric.api import env, lcd, local, task, execute
from fabdeploytools import helpers

import deploysettings as settings

env.key_filename = settings.SSH_KEY
fabdeploytools.envs.loadenv(settings.CLUSTER)

SCL_NAME = getattr(settings, 'SCL_NAME', False)
if SCL_NAME:
    helpers.scl_enable(SCL_NAME)

ROOT, APP = helpers.get_app_dirs(__file__)

VIRTUALENV = pjoin(ROOT, 'venv')
PYTHON = pjoin(VIRTUALENV, 'bin', 'python')
SRC = pjoin(APP, 'src')

USER_DATA = pjoin(settings.DATA_PATH, 'dumped-users', 'users')
APP_DATA = pjoin(settings.DATA_PATH, 'dumped-apps', 'apps')

os.environ['DJANGO_SETTINGS_MODULE'] = 'recommendation.settings.local'


def managecmd(cmd, run_dir=SRC):
    with lcd(run_dir):
        local('%s manage.py %s' % (PYTHON, cmd))


@task
def create_virtualenv(update_on_change=True):
    helpers.create_venv(VIRTUALENV, settings.PYREPO,
                        pjoin(APP, 'requirements.prod.txt'),
                        update_on_change=update_on_change)


@task
def pre_update(ref):
    with lcd(APP):
        local('git fetch')
        local('git fetch -t')
        local('git reset --hard %s' % ref)
        create_virtualenv()


@task
def syncdb(run_dir=SRC):
    managecmd('syncdb', run_dir)


@task
def update():
    syncdb()


@task
def deploy():
    helpers.deploy(name=settings.PROJECT_NAME,
                   app_dir='frappe',
                   env=settings.ENV,
                   cluster=settings.CLUSTER,
                   domain=settings.DOMAIN,
                   package_dirs=['frappe', 'venv'],
                   root=ROOT)

    helpers.restart_uwsgi(getattr(settings, 'UWSGI', []))


@task
def build():
    execute(create_virtualenv)


@task
def deploy_jenkins():
    rpm = helpers.build_rpm(name=settings.PROJECT_NAME,
                            app_dir='frappe',
                            env=settings.ENV,
                            cluster=settings.CLUSTER,
                            domain=settings.DOMAIN,
                            package_dirs=['frappe', 'venv'],
                            root=ROOT)

    rpm.local_install()
    execute(syncdb, os.path.join(rpm.install_to, 'frappe', 'src'))
    helpers.restart_uwsgi(getattr(settings, 'UWSGI', []))


@task
def cron():
    fill_data()
    modelcrafter()
    helpers.restart_uwsgi(getattr(settings, 'UWSGI', []))


@task
def fill_data():
    managecmd('fill items --mozilla %s' % APP_DATA)
    managecmd('fill users --mozilla %s' % USER_DATA)


@task
def modelcrafter():
    managecmd('modelcrafter train tensorcofi')
    managecmd('modelcrafter train popularity')
