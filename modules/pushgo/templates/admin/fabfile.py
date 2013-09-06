import os
from fabdeploytools import helpers
from fabdeploytools.envs import loadenv
from fabric.api import lcd, local, sudo, task

ENV = '<%= environ %>'
CLUSTER = '<%= cluster %>'
DOMAIN = '<%= servername %>'
S3BUCKET = '<%= s3_bucket %>'
loadenv(CLUSTER)

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
                   env=ENV,
                   cluster=CLUSTER,
                   domain=DOMAIN,
                   package_dirs=['pushgo/pushgo'],
                   use_sudo=True,
                   s3_bucket=S3BUCKET,
                   root=ROOT)
    sudo('circusctl restart pushgo')
