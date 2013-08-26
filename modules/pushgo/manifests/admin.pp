# pushgo admin server.
class pushgo::admin(
    $cluster='pushgo.prod'
){
    $cluster_src = "/data/${cluster}/src"
    git::clone {
        "${cluster_src}/push.mozilla.com/pushgo":
            repo => 'https://github.com/jrconlin/pushgo.git';
    }

    file {
        "${cluster_src}/push.mozilla.com/fabfile.py":
            content => template('pushgo/admin/fabfile.py');
    }
}
