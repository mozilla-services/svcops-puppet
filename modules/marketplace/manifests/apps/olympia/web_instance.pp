# define olympia instance.
define marketplace::apps::olympia::web_instance(
  $app_dir,
  $port,
  $appmodule = 'wsgi.zamboni:application',
  $environ = undef,
  $newrelic_domain = undef,
  $newrelic_license_key = '',
  $nginx_settings = undef,
  $settings_module = 'settings_local',
  $timeout = '90',
  $user = 'mkt_prod',
  $uwsgi_max_requests = '5000',
  $worker_class = 'sync',
  $worker_name = 'addons-olympia-dev',
  $workers = 12,
) {

  $app_name = $name

  if $environ {
    $environment = "DJANGO_SETTINGS_MODULE=${settings_module},${environ}"
  }
  else {
    $environment = "DJANGO_SETTINGS_MODULE=${settings_module}"
  }

  if $newrelic_license_key {
    marketplace::newrelic::python { $app_name:
      before          => Uwsgi::Instance[$worker_name],
      newrelic_domain => $newrelic_domain,
      license_key     => $newrelic_license_key,
    }
  }


  uwsgi::instance { $worker_name:
    app_dir      => "${app_dir}/olympia",
    appmodule    => $appmodule,
    environ      => $environment,
    home         => "${app_dir}/venv",
    max_requests => $uwsgi_max_requests,
    port         => $port,
    user         => $user,
    workers      => $workers,
    lazy_apps    => false,
  }

  if $nginx_settings {
    $nginx_resources = {
      "${app_name}" => $nginx_settings
    }

    $nginx_defaults = {
      'app_name'    => 'olympia',
      'webroot'     => $app_dir,
      'worker_name' => "uwsgi_${worker_name}",
    }
    create_resources(marketplace::nginx::addons, $nginx_resources, $nginx_defaults)
  }
}
