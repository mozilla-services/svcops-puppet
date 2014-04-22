# blocklist nginx config
define marketplace::nginx::blocklist_instance(
  $server_names # ['blocklist-dev.allizom.org']
) {
  $config_name = $name

  nginx::config {
    $config_name:
      content => template('marketplace/nginx/blocklist.conf');
  }

  nginx::logdir {
    $config_name:;
  }
}
