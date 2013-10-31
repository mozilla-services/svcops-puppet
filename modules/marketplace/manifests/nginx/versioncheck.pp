# versioncheck nginx config
define marketplace::nginx::versioncheck(
    $server_names # ['versioncheck-dev.allizom.org']
) {
    $config_name = $name

    nginx::config {
        $config_name:
            content => template('marketplace/nginx/versioncheck.conf');
    }

    nginx::logdir {
        $config_name:;
    }
}
