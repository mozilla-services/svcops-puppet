# vim: set expandtab ts=2 sw=2 filetype=puppet syntax=puppet:
define marketplace::apps::trunion::web_instance(
  $worker_name,
  $app_dir,
  $appmodule = 'trunion.run:application',
  $auth_users = undef,
  $lazy_apps = undef,
  $max_requests = undef,
  $nginx_log_buffer = true,
  $nginx_enable_ssl = false,
  $nginx_ssl_cert = undef,
  $nginx_ssl_key = undef,
  $nginx_port = '80',
  $nginx_ssl_port = '81',
  $nginx_template = 'marketplace/nginx/trunion.conf',
  $port = '000',
  $user = 'nobody',
  $workers = 4,
) {
  include marketplace::apps::trunion::packages

  $app_name = $name
  $environ = "TRUNION_INI=${app_dir}/trunion/production.ini, LD_LIBRARY_PATH=/opt/nfast/toolkits/hwcrhk"

  if $port < 1000 {
    $real_port =  "12${port}"
  } else {
    $real_port = $port
  }


  uwsgi::instance {
    $worker_name:
      app_dir      => "${app_dir}/trunion",
      appmodule    => $appmodule,
      environ      => $environ,
      home         => "${app_dir}/venv",
      lazy_apps    => $lazy_apps,
      max_requests => $max_requests,
      port         => $real_port,
      user         => $user,
      workers      => $workers,
  }

  if $auth_users {
    nginx::htpasswd {
      $app_name:
        auth_users => $auth_users,
        before     => Nginx::Config[$app_name],
    }
  }

  nginx::config {
    $app_name:
      content => template($nginx_template);
  }

  nginx::logdir {
    $app_name:;
  }

}
