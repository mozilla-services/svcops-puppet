# zippy web
define marketplace::apps::zippy::web_instance(
  $env,
  $port,
  $project_dir,
  $user = 'nobody'
) {
  $domain = $name

  package { "deploy-zippy-${env}":
    ensure => 'installed',
  }->
  supervisord::service { "zippy-${domain}":
    app_dir => "${project_dir}/zippy",
    command => "/usr/bin/node main.js -p ${port}",
    user    => $user,
  }->
  nginx::serverproxy { $domain:
    listen    => '81',
    proxyto   => "http://localhost:${port}",
    ssl_proxy => true
  }
}
