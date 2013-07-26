# theme_update nginx config
define marketplace::nginx::theme_update(
    $server_names # ['theme-update.dev.allizom.org']
) {
    $config_name = $name

    nginx::config {
        $config_name:
            content => template('marketplace/nginx/theme_update.conf');
    }

    nginx::logdir {
        $config_name:;
    }
}
