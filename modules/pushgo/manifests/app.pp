# pushgo app
class pushgo::app {
    include pushgo::sysctl
    include pushgo::config
    include supervisord::base

    supervisord::service {
        'pushgo':
            require => File['/etc/pushgo.ini'],
            command => '/data/pushgo.prod/www/push.mozilla.com/current/pushgo/pushgo -config=/etc/pushgo.ini',
            app_dir => '/data/pushgo.prod/www/push.mozilla.com',
            user    => 'root';
    }
}
