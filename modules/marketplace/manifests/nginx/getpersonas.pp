# getpersonas nginx config
define marketplace::nginx::getpersonas(
    $server_names # ['getpersonas.com']
) {
    $config_name = $name

    nginx::config {
        $config_name:
            content => template('marketplace/nginx/getpersonas.conf');
    }

    nginx::logdir {
        $config_name:;
    }
}
