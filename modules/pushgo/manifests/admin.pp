# pushgo admin server.
class pushgo::admin(
    $cluster='pushgo.prod',
    $s3_bucket='bucket'
){
    $cluster_src = "/data/${cluster}/src"
    package {
        'libmemcached-devel':
            ensure => '1.0.16-1.el6';
    }

    git::clone {
        "${cluster_src}/push.mozilla.com/pushgo":
            repo => 'https://github.com/jrconlin/pushgo.git';
    }

    file {
        "${cluster_src}/push.mozilla.com/fabfile.py":
            require => Git::Clone["${cluster_src}/push.mozilla.com/pushgo"],
            content => template('pushgo/admin/fabfile.py');
    }
}
