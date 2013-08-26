import os
from fabdeploytools import helpers
from fabdeploytool.envs import loadenv
from fabric.api import task

loadenv('<%= cluster %>')

ROOT = os.path.dirname(__file__)
APP = os.path.join(ROOT, 'pushgo')


@task
def pre_update(ref):
    helpers.git_update(APP)


@task
def update():
    pass


@task
def deploy():
    helpers.deploy(name='pushgo',
                   env='prod',
                   cluster='pushgo.prod',
                   domain='push.mozilla.com',
                   root=ROOT)
