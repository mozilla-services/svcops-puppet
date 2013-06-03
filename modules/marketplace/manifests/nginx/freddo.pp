# pfs nginx config
define marketplace::nginx::freddo(
    $server_names
) {
    $config_name = $name

    nginx::config {
        $config_name:
            content => template('marketplace/nginx/freddo.conf');
    }

    nginx::logdir {
        $config_name:;
    }
}
