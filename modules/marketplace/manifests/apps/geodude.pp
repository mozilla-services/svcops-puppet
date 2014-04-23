# define geodude instance.
define marketplace::apps::geodude(
  $worker_name,
  $port,
  $app_dir,
  $appmodule = 'geodude',
  $workers = 12,
  $worker_class = 'sync',
  $timeout = '90',
  $environ = '',
  $newrelic_domain = undef,
  $newrelic_license_key = '',
  $user = 'mkt_prod_geodude',
  $uwsgi = true
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
      app_dir   => "${app_dir}/geodude",
      appmodule => $appmodule,
      port      => $real_port,
      home      => "${app_dir}/venv",
      user      => $user,
      workers   => $workers,
      environ   => $environ;
  }
}
