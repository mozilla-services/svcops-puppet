# add a cluster to the admin server
define pushgo::admin_cluster(
    $s3_bucket,
    $environ,
    $servername
) {
    $cluster = $name
    $cluster_src = "/data/${cluster}/src"
    git::clone {
        "${cluster_src}/push.mozilla.com/pushgo":
            repo => 'https://github.com/mozilla-services/pushgo.git';
    }

    file {
        "${cluster_src}/push.mozilla.com/fabfile.py":
            require => Git::Clone["${cluster_src}/push.mozilla.com/pushgo"],
            content => template('pushgo/admin/fabfile.py');
    }
}
