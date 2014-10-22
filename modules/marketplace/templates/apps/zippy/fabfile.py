import os

import fabdeploytools.envs
from fabric.api import env, execute, lcd, local, parallel, roles, run, task
from fabdeploytools import helpers

import deploysettings as settings

env.key_filename = settings.SSH_KEY
fabdeploytools.envs.loadenv(settings.CLUSTER)
ROOT, APP = helpers.get_app_dirs(__file__)

WORKER = 'zippy-<%= @domain %>'

if not os.environ.get('HOME'):
    os.environ['HOME'] = '/tmp'


@task
def pre_update(ref):
    with lcd(APP):
        local('git fetch')
        local('git fetch -t')
        local('git reset --hard %s' % ref)


@task
def update():
    with lcd(APP):
        local('npm install')
        local('npm install grunt-cli')
        local('./node_modules/.bin/grunt stylus')


@task
@roles('web')
@parallel
def restart_worker():
    run('supervisorctl restart %s' % WORKER)


@task
def deploy():
    helpers.deploy(name=settings.PROJECT_NAME,
                   app_dir='zippy',
                   env=settings.ENV,
                   cluster=settings.CLUSTER,
                   domain=settings.DOMAIN,
                   root=ROOT)
    execute(restart_worker)
