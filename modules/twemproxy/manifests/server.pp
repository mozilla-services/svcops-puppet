define twemproxy::server(
    $pools
) {
    include concat::setup

    $server_name = $name
    $config_file = "/etc/nutcracker/${server_name}.yml"
    $pool_defaults = {
        'config_file' => $config_file,
    }

    concat {
        $config_file:
            owner => root,
            group => root,
            mode  => '0644';
    }

    create_resources(twemproxy::pool, $pools, $pool_defaults)
}
