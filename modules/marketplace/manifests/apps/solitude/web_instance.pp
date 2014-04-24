# solitude web instance
define marketplace::apps::solitude::web_instance(
  $port,
  $project_dir,
  $server_names, # ['payments.mozilla.org']
  $appmodule = 'wsgi.playdoh:application',
  $is_proxy = false,
  $newrelic_license_key = '',
  $nginx_port = '81',
  $scl = undef,
  $settings_module = 'solitude.settings',
  $user = 'sol_prod',
  $workers = 12,
  $worker_name = 'payments',
) {
  $config_name = $name

  if $is_proxy {
    $environ = ',SOLITUDE_PROXY=\'enabled\''
  } else {
    $environ = ''
  }

  if $newrelic_license_key {
    marketplace::newrelic::python {
      $config_name:
        before      => Uwsgi::Instance[$worker_name],
        license_key => $newrelic_license_key;
    }
  }

  uwsgi::instance {
    $worker_name:
      app_dir   => "${project_dir}/solitude",
      appmodule => $appmodule,
      port      => $port,
      home      => "${project_dir}/venv",
      user      => $user,
      workers   => $workers,
      scl       => $scl,
      environ   => "DJANGO_SETTINGS_MODULE=${settings_module}${environ}";
  }

  nginx::config {
    $config_name:
      require => Uwsgi::Instance[$worker_name],
      content => template('marketplace/apps/solitude/web/nginx.conf');
  }

  nginx::logdir {
    $config_name:;
  }
}
