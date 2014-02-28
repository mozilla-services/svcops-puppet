# define olympia instance.
define marketplace::apps::olympia::web_instance(
  $app_dir,
  $port,
  $appmodule = 'wsgi.zamboni:application',
  $workers = 12,
  $worker_class = 'sync',
  $timeout = '90',
  $environ = '',
  $newrelic_license_key = '',
  $newrelic_domain = undef,
  $user = 'mkt_prod'
) {

  $app_name = $name

  if $newrelic_license_key {
    marketplace::newrelic::python { $app_name:
      before          => Uwsgi::Instance[$app_name],
      newrelic_domain => $newrelic_domain,
      license_key     => $newrelic_license_key,
    }
  }

  uwsgi::instance { $app_name:
    app_dir   => "${app_dir}/zamboni",
    appmodule => $appmodule,
    port      => "12${port}",
    home      => "${app_dir}/venv",
    user      => $user,
    workers   => $workers,
    environ   => $environ,
  }
}
