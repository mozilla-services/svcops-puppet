# pfs nginx config
define marketplace::nginx::geoip(
    $server_names # ['geoip.marketplace.firefox.com']
) {
    $config_name = $name

    nginx::config {
        $config_name:
            content => template('marketplace/nginx/geoip.conf');
    }

    nginx::logdir {
        $config_name:;
    }
}
