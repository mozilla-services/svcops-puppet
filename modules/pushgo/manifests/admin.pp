# pushgo admin server.
class pushgo::admin(
    $clusters={'pushgo.dev' => {
                                s3_bucket  => 'bucket'
                                environ    => 'dev',
                                servername => 'pushgo.dev.mozilla.com'}}
){
    package {
        'libmemcached-devel':
            ensure => '1.0.16-1.el6';
    }
    create_resources(pushgo::admin_cluster, $clusters)
}
