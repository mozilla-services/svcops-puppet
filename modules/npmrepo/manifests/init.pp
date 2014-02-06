# npmrepo
class npmrepo(
    $server_name,
    $app_dir = '/opt/npm_lazy_mirror',
    $worker_name = 'npm_lazy_mirror'
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
            command => "${app_dir}/bin/npm_lazy_mirror -C ${npmrepo::config::config_file}",
            app_dir => $app_dir,
            user    => 'nobody',
            require => [
                        Class['npmrepo::config'],
                        Class['npmrepo::packages'],
            ];
    }

}
