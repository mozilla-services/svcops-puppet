# define services.addons nginx config
define marketplace::nginx::services_addons(
  $webroot
) {
  $server_name = $name
  nginx::config {
    $server_name:
      content => template('marketplace/nginx/services_addons.conf');
  }

  nginx::logdir {
    $server_name:;
  }
}
