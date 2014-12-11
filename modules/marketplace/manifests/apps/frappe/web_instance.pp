# define frappe instance.
define marketplace::apps::frappe::web_instance(
  $port,
  $project_dir,
  $user,
  $appmodule = 'recommendation.settings.wsgi:application',
  $cache = 'name=userfactors,items=1500000,blocksize=80,keysize=100',
  $nginx_port = '83',
  $offload_threads = 1,
  $scl = undef,
  $timeout = '90',
  $worker_name = 'frappe',
  $workers = 2,
) {

  $config_name = $name
  $environ = 'DJANGO_SETTINGS_MODULE=recommendation.settings.local'

  uwsgi::instance {
    $worker_name:
      app_dir         => "${project_dir}/frappe/src",
      appmodule       => $appmodule,
      environ         => $environ,
      home            => "${project_dir}/venv",
      offload_threads => $offload_threads,
      port            => $port,
      scl             => $scl,
      user            => $user,
      workers         => $workers,
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
