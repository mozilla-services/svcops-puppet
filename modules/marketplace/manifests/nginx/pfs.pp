# pfs nginx config
define marketplace::nginx::pfs(
  $server_names # ['pfs.mozilla.org']
) {
  $config_name = $name

  nginx::config {
    $config_name:
      content => template('marketplace/nginx/pfs.conf');
  }

  nginx::logdir {
    $config_name:;
  }
}
