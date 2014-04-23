# vim: set expandtab ts=2 sw=2 filetype=puppet syntax=puppet:
define marketplace::apps::trunion::web_instance(
  $worker_name,
  $app_dir,
  $appmodule = 'trunion.run:application',
  $port = '000',
  $nginx_port = '80',
  $nginx_ssl_port = '81',
  $nginx_template = 'marketplace/nginx/trunion.conf',
  $nginx_log_buffer = true,
  $user = 'nobody',
  $workers = 4
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
      app_dir   => "${app_dir}/trunion",
      appmodule => $appmodule,
      port      => $real_port,
      home      => "${app_dir}/venv",
      user      => $user,
      workers   => $workers,
      environ   => $environ;
  }

  nginx::config {
    $app_name:
      content => template($nginx_template);
  }

  nginx::logdir {
    $app_name:;
  }

}
