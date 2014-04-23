# addon_registration nginx config
define marketplace::nginx::addon_registration(
  $server_names # ['registration-dev.allizom.org']
) {
  $config_name = $name

  nginx::config {
    $config_name:
      content => template('marketplace/nginx/addon_registration.conf');
  }

  nginx::logdir {
    $config_name:;
  }
}
