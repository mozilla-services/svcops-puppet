# describe monolith on a webserver.
define marketplace::apps::monolith::web_instance(
    $server_names, # a list of names
    $elasticsearch_endpoint,
    $es_index_prefix = '',
    $user = 'mkt_prod_monolith'
) {
    $config_name = $name

    $es_location = $es_index_prefix ? {
        ''      => 'time',
        default => "${es_index_prefix}-time"
    }

    nginx::config {
        $config_name:
            require => Nginx::Upstream::Multiple['monolith-es'],
            content => template('marketplace/apps/monolith/web/monolith.conf');
    }

    nginx::upstream::multiple {
        'monolith-es':
            keepalive => true,
            upstream  => $elasticsearch_endpoint
    }

    nginx::logdir {
        $config_name:;
    }
}
