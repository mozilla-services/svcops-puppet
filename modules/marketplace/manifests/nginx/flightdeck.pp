# defines an flightdeck nginx config
define marketplace::nginx::flightdeck(
    $server_names, # ['builder-addons-dev.allizom.org']
    $webroot, #  /data/www/builder-addons-dev.allizom.org/flightdeck
    $template_file = 'marketplace/nginx/flightdeck.conf'
) {
    $config_name = $name

    nginx::config {
        $config_name:
            content => template($template_file);
    }

    nginx::logdir {
        $config_name:;
    }
}
