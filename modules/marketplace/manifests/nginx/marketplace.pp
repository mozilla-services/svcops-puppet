# defines a marketplace nginx config
define marketplace::nginx::marketplace(
    $server_names, # ['marketplace.firefox.com', 'telefonica.marketplace.mozilla.org']
    $cdn_server_names, # ['marketplace-static.addons.mozilla.net']
    $https_redirect_names, # ['marketplace.mozilla.org', 'marketplace.firefox.com', 'marketplace-static.addons.mozilla.net', 'telefonica.marketplace.mozilla.org']
    $https_redirect_to, # marketplace.firefox.com
    $webroot, # /data/www/addons.mozilla.org
    $webpayroot, # /data/www/marketplace.firefox.com-webpay,
    $cdn_hostname, # marketplace.cdn.mozilla.net
    $netapp_root # /mnt/netapp_amo/addons.mozilla.org

) {
    $config_name = $name

    nginx::config {
        $config_name:
            content => template('marketplace/nginx/marketplace.conf');
    }

    nginx::logdir {
        $config_name:;
    }
}
