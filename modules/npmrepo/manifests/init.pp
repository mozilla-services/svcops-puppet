# npmrepo
class npmrepo(
    $server_name,
    $app_dir = '/opt/npm-lazy-mirror',
    $worker_name = 'npm-lazy-mirror'
){

    $upstream = $worker_name

    include npmrepo::packages
    include npmrepo::config

    nginx::upstream {
        $upstream:
            upstream_port => $npmrepo::config::port,
            require       => Supervisord::Service[$worker_name];
    }

    nginx::serverproxy {
        $server_name:
            proxyto => "http://${upstream}";
    }

    supervisord::service {
        $worker_name:
            command => "${app_dir}/bin/npm-lazy-mirror -C ${npmrepo::config::config_file}",
            app_dir => $app_dir,
            user    => 'nobody',
            require => [
                        Class['npmrepo::config'],
                        Class['npmrepo::packages'],
            ];
    }

}
