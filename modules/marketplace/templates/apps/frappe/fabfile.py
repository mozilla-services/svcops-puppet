import os
from os.pathpath import join as pjoin

import fabdeploytools.envs
from fabric.api import env, lcd, local, task
from fabdeploytools import helpers

import deploysettings as settings

env.key_filename = settings.SSH_KEY
fabdeploytools.envs.loadenv(settings.CLUSTER)
ROOT, APP = helpers.get_app_dirs(__file__)

VIRTUALENV = pjoin(ROOT, 'venv')
PYTHON = pjoin(VIRTUALENV, 'bin', 'python')


@task
def create_virtualenv(update_on_change=True):
    helpers.create_venv(VIRTUALENV, settings.PYREPO,
                        pjoin(APP, 'requirements.txt'),
                        update_on_change=update_on_change)


@task
def pre_update(ref):
    with lcd(APP):
        local('git fetch')
        local('git fetch -t')
        local('git reset --hard %s' % ref)


@task
def update():
    placeholder = None


@task
def deploy():
    helpers.deploy(name=settings.PROJECT_NAME,
                   app_dir='frappe',
                   env=settings.ENV,
                   cluster=settings.CLUSTER,
                   domain=settings.DOMAIN,
                   root=ROOT)
