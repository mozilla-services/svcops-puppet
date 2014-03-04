# defines an addons nginx config
# name/config_name is also the default url e.g., addons.mozilla.org
define marketplace::nginx::addons(
    $server_names, # ['addons.mozilla.org', 'addons.update.mozilla.org', 'addons-nl.stage.mozilla.com', 'm.addons.mozilla.org', '*.add-ons.mozilla.com']
    $cdn_server_names, # ['addons-cdn.mozilla.net', 'static.addons.mozilla.net', 'static-ssl-cdn.addons.mozilla.net']
    $https_redirect_names, # ['addons.mozilla.org', 'addons.update.mozilla.org', 'addons-nl.stage.mozilla.com', 'addons-cdn.mozilla.net', 'static.addons.mozilla.net', 'm.addons.mozilla.org']
    $webroot, # /data/www/addons.mozilla.org
    $cdn_hostname, # addons.cdn.mozilla.net
    $netapp_root, # /mnt/netapp_amo/addons.mozilla.org
    $app_name = 'zamboni',
    $versioncheck_url = 'https://versioncheck.addons.mozilla.org',
    $worker_name = 'uwsgi_addons',
    $template_file = 'marketplace/nginx/addons.conf',
    $addons_redirect_names = undef # should be a list of domains that should be redirected to $config_name
) {
    $config_name = $name

    nginx::config {
        $config_name:
            content => template($template_file);
    }

    nginx::config {
        "${config_name}-sdkredirects":
            content => template('marketplace/nginx/addons/sdk_redirects.conf'),
            suffix  => '.include';
    }

    nginx::logdir {
        $config_name:;
    }
}
