# pushgo app
class pushgo::app {
    include pushgo::sysctl
    include pushgo::config
    include supervisord::base

    supervisord::service {
        'pushgo':
            require => File['/etc/pushgo.ini'],
            command => '/opt/pushgo/pushgo -config=/etc/pushgo.ini',
            app_dir => '/opt/pushgo',
            user    => 'root';
    }
}
