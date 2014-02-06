# npmrepo
class npmrepo(
    $server_name,
    $app_dir = '/opt/npm-lazy-mirror',
    $worker_name = 'npm-lazy-mirror'
){

    $upstream = $worker_name

    include npmrepo::packages

    class {
        'npmrepo::config':
            server_name => $server_name;
    }

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
            command => "/usr/bin/node ${app_dir}/server.js -C ${npmrepo::config::config_file} --real_external_port 443 --upstream_use_https",
            app_dir => $app_dir,
            user    => 'nobody',
            require => [
                Class['npmrepo::config'],
                Class['npmrepo::packages'],
            ];
    }

}
