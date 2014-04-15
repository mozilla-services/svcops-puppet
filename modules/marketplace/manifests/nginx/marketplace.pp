# defines a marketplace nginx config
define marketplace::nginx::marketplace(
    $server_names, # ['marketplace.firefox.com', 'telefonica.marketplace.mozilla.org']
    $cdn_server_names, # ['marketplace-static.addons.mozilla.net']
    $https_redirect_names, # ['marketplace.mozilla.org', 'marketplace.firefox.com', 'marketplace-static.addons.mozilla.net', 'telefonica.marketplace.mozilla.org']
    $https_redirect_to, # marketplace.firefox.com
    $webroot, # /data/www/addons.mozilla.org
    $webpayroot, # /data/www/marketplace.firefox.com-webpay,
    $cdn_hostname, # marketplace.cdn.mozilla.net
    $netapp_root, # /mnt/netapp_amo/addons.mozilla.org
    $marketplace_worker_name = 'marketplace',
    $webpay_worker_name = 'webpay-marketplace',
    $template_file = 'marketplace/nginx/marketplace.conf',
    $fireplace_root = '',
    $commbadge_root = '',
    $landfill_dumps = undef,
    $rocketfuel_root = '',
    $marketplace_stats_root = '',
    $mkt_redirects = undef,
) {
    $config_name = $name

    if $fireplace_root {
        $fireplace_webroot = $fireplace_root
    } else {
        $fireplace_webroot = $webroot
    }

    if $commbadge_root {
        $commbadge_webroot = $commbadge_root
    } else {
        $commbadge_webroot = $webroot
    }

    if $rocketfuel_root {
        $rocketfuel_webroot = $rocketfuel_root
    } else {
        $rocketfuel_webroot = $webroot
    }

    if $marketplace_stats_root {
        $marketplace_stats_webroot = $marketplace_stats_root
    } else {
        $marketplace_stats_webroot = $webroot
    }

    nginx::config {
        $config_name:
            content => template($template_file);
    }

    nginx::logdir {
        $config_name:;
    }
}
