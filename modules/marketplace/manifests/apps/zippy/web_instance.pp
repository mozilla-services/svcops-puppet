# zippy web
define marketplace::apps::zippy::web_instance(
  $env,
  $port,
  $project_dir,
  $user = 'nobody'
) {
  $app_name = $name

  package { "deploy-zippy-${env}":
    ensure => 'installed',
  }->
  supervisord::service { "zippy-${app_name}":
    app_dir => "${project_dir}/zippy",
    command => "/usr/bin/node main.js -p ${port}",
    user    => $user,
  }
}
