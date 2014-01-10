define twemproxy::pool(
    $listen,
    $servers,
    $config_file,
    $twemproxy_hash = 'fnv1a_64',
    $distribution = 'ketama',
    $server_timeout = '1000',
    $listen_backlog = '512',
    $redis = 'false',
    $preconnect = 'false',
    $auto_eject_hosts = 'false',
    $server_retry_timeout = '30000',
    $server_failure_limit = '2',
    $server_connections = '1'
)
{
    $pool_name = $name
    concat::fragment {
        "twemproxypool:${pool_name}":
            target  => $config_file,
            content => template('twemproxy/pool.yaml');
    }
}
