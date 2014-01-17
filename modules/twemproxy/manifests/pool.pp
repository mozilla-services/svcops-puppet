# add a pool to a twemproxy config.
define twemproxy::pool(
    $server_name,
    $servers = [],
    $listen = '127.0.0.1:22122',
    $twemproxy_hash = 'fnv1a_64',
    $distribution = 'ketama',
    $server_timeout = '1000',
    $listen_backlog = '512',
    $redis = false,
    $preconnect = false,
    $auto_eject_hosts = false,
    $server_retry_timeout = '30000',
    $server_failure_limit = '2',
    $server_connections = '1'
)
{
    include twemproxy
    $pool_name = $name
    concat::fragment {
        "twemproxypool:${pool_name}":
            target  => "${twemproxy::config_dir}/${server_name}.yml",
            content => template('twemproxy/pool.yaml');
    }
}
