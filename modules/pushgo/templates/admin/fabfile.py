import os
from fabdeploytools import helpers
from fabdeploytools.envs import loadenv
from fabric.api import lcd, local, task

loadenv('<%= cluster %>')
S3BUCKET = '<%= s3_bucket %>'

ROOT = os.path.dirname(__file__)
APP = os.path.join(ROOT, 'pushgo')


@task
def pre_update(ref):
    helpers.git_update(APP, ref)


@task
def update():
    pass


@task
def deploy():
    with lcd(APP):
        local('GOPATH=$(pwd) GOBIN=$(pwd) go build')
    helpers.deploy(name='pushgo',
                   env='prod',
                   cluster='pushgo.prod',
                   domain='push.mozilla.com',
                   package_dirs=['pushgo/pushgo'],
                   use_sudo=True,
                   s3_bucket=S3BUCKET,
                   root=ROOT)
    run('circusctl restart pushgo')
