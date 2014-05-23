# geodude web instance
define marketplace::apps::geodude::web_instance(
  $port,
  $project_dir,
  $server_names, # ['geodude.marketplace.firefox.com']
  $appmodule = 'geodude',
  $scl = undef,
  $user = 'mkt_prod_geodude',
  $worker_name = 'geodude',
  $workers = 12,
) {
  $config_name = $name

  uwsgi::instance {
    $worker_name:
      app_dir   => "${project_dir}/geodude",
      appmodule => $appmodule,
      port      => $port,
      home      => "${project_dir}/venv",
      user      => $user,
      workers   => $workers,
      scl       => $scl,
  }

  marketplace::nginx::geodude {
    $config_name:
      server_names => $server_names
  }
}
