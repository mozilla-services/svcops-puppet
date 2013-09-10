# pushgo app
class pushgo::app(
    $cluster = 'pushgo.prod',
    $domain = 'push.mozilla.com'
){
    $app_root = "/data/${cluster}/www/${domain}"
    include pushgo::sysctl
    include pushgo::config
    include pushgo::packages

    circus::watcher {
        'pushgo':
            require                => File['/etc/pushgo.ini'],
            cmd                    => "${app_root}/current/pushgo/pushgo -config=/etc/pushgo.ini",
            rlimit_nofile          => '1000000';
    }
}
