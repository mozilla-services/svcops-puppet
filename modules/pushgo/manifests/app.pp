# pushgo app
class pushgo::app {
    include pushgo::sysctl
    include pushgo::config

    circus::watcher {
        'pushgo':
            require       => File['/etc/pushgo.ini'],
            cmd           => '/data/pushgo.prod/www/push.mozilla.com/current/pushgo/pushgo -config=/etc/pushgo.ini',
            rlimit_nofile => '1000000';

    }
}
