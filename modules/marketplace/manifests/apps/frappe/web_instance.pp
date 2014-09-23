# define frappe instance.
define marketplace::apps::frappe::web_instance(
  $port,
  $project_dir,
  $user,
  $appmodule = 'recommendation.wsgi:application',
  $nginx_port = '83',
  $scl = undef,
  $timeout = '90',
  $worker_name = 'frappe',
  $workers = 4,
) {

  $config_name = $name
  $environ = 'DJANGO_SETTINGS_MODULE=recommendation.local'

  uwsgi::instance {
    $worker_name:
      app_dir   => "${project_dir}/frappe/src",
      appmodule => $appmodule,
      environ   => $environ,
      home      => "${project_dir}/venv",
      port      => $port,
      scl       => $scl,
      user      => $user,
      workers   => $workers,
  }

  nginx::config {
    $config_name:
      require => Uwsgi::Instance[$worker_name],
      content => template('marketplace/apps/frappe/web/nginx.conf');
  }

  nginx::logdir {
    $config_name:;
  }
}
