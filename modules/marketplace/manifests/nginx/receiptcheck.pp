# defines a receiptcheck nginx config
define marketplace::nginx::receiptcheck(
  $server_names, # ['receiptcheck.marketplace.mozilla.org', 'receiptcheck.marketplace.firefox.com']
  $webroot, # /data/www/addons.mozilla.org
) {
  $config_name = $name

  nginx::config {
    $config_name:
      content => template('marketplace/nginx/receiptcheck.conf');
  }

  nginx::logdir {
    $config_name:;
  }
}
