# start a twemproxy server.
define twemproxy::server(
    $pools
) {
    include concat::setup

    $server_name = $name
    $service_name = "twemproxy-${server_name}"
    $config_file = "/etc/nutcracker/${server_name}.yml"
    $pool_defaults = {
        'config_file' => $config_file,
        'before'      => Supervisord::Service[$service_name]
    }

    concat {
        $config_file:
            owner => root,
            group => root,
            mode  => '0644';
    }

    create_resources(twemproxy::pool, $pools, $pool_defaults)

    supervisord::service {
        $service_name:
            command => "/usr/sbin/nutcracker -c \"${config_file}\"",
            app_dir => '/tmp',
            user    => 'nobody';
    }
}
