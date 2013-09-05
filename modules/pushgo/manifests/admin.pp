# pushgo admin server.
class pushgo::admin(
    $clusters={'pushgo.prod' => {s3_bucket => 'bucket'}}
){
    package {
        'libmemcached-devel':
            ensure => '1.0.16-1.el6';
    }
    create_resources(pushgo::admin_cluster, $clusters)
}
