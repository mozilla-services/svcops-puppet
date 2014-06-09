# define zamboni instance.
define marketplace::apps::zamboni(
  $worker_name,
  $app_dir,
  $port, # if this gunicorn_set is turned on, this is prefixed with 10 and 11.
  $appmodule = 'wsgi.zamboni:application',
  $environ = '',
  $newrelic_domain = undef,
  $newrelic_license_key = '',
  $nginx_settings = undef,
  $settings_module = 'settings_local_mkt',
  $timeout = '90',
  $user = 'mkt_prod',
  $uwsgi = true,
  $worker_class = 'sync',
  $workers = 12,
) {
  $app_name = $name

  if $port < 1000 {
    $real_port =  "12${port}"
  } else {
    $real_port = $port
  }

  if $newrelic_license_key {
    $newrelic_dep = Uwsgi::Instance[$worker_name]
    marketplace::newrelic::python {
      $app_name:
        before          => $newrelic_dep,
        newrelic_domain => $newrelic_domain,
        license_key     => $newrelic_license_key;
    }
  }

  uwsgi::instance {
    $worker_name:
      app_dir   => "${app_dir}/zamboni",
      appmodule => $appmodule,
      port      => $real_port,
      home      => "${app_dir}/venv",
      user      => $user,
      workers   => $workers,
      environ   => "DJANGO_SETTINGS_MODULE=${settings_module},${environ}",
  }

  if $nginx_settings {
    create_resources(
      marketplace::nginx::marketplace,
      {"${app_name}" => $nginx_settings},
      {
        webpayroot              => $app_dir,
        webroot                 => $app_dir,
        marketplace_worker_name => $worker_name
      }
    )
  }
}
