# defines a receiptcheck nginx config
define marketplace::nginx::monolith(
    $server_names, # ['receiptcheck.marketplace.mozilla.org', 'receiptcheck.marketplace.firefox.com']
    $worker_name
) {
    $config_name = $name

    nginx::config {
        $config_name:
            require => Uwsgi[$worker_name],
            content => template('marketplace/nginx/monolith.conf');
    }

    nginx::logdir {
        $config_name:;
    }
}
