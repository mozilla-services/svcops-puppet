# defines a receiptcheck nginx config
define marketplace::nginx::receiptcheck_instance(
  $server_names, # ['receiptcheck.marketplace.mozilla.org', 'receiptcheck.marketplace.firefox.com']
  $webroot, # /data/www/addons.mozilla.org
  $worker_name = 'receiptcheck-marketplace',
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
