# pushgo app
class pushgo::app {
    include pushgo::sysctl
    include pushgo::config
    include supervisord::base

#    circus::watcher {
#        'pushgo':
#            require       => File['/etc/pushgo.ini'],
#            cmd           => '/data/pushgo.prod/www/push.mozilla.com/current/pushgo/pushgo -config=/etc/pushgo.ini',
#            rlimit_nofile => '1000000';
#
#    }
    supervisord::service {
        'pushgo':
            require => File['/etc/pushgo.ini'],
            command => '/data/pushgo.prod/www/push.mozilla.com/current/pushgo/pushgo -config=/etc/pushgo.ini',
            app_dir => '/data/pushgo.prod/www/push.mozilla.com',
            user    => 'root';
    }
}
