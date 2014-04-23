# pfs nginx config
define marketplace::nginx::geodude(
  $server_names # ['geo.marketplace.firefox.com']
) {
  $config_name = $name

  nginx::config {
    $config_name:
      content => template('marketplace/nginx/geodude.conf');
  }

  nginx::logdir {
    $config_name:;
  }
}
