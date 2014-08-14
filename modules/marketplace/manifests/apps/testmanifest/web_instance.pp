# testmanifest web
define marketplace::apps::testmanifest::web_instance(
  $env,
  $port,
  $project_dir,
  $user = 'nobody'
) {
  $domain = $name

  package { "deploy-testmanifest-${env}":
    ensure => 'installed',
  }->
  supervisord::service { "testmanifest-${domain}":
    app_dir => "${project_dir}",
    command => "/usr/bin/node index.js -p ${port}",
    user    => $user,
  }->
  nginx::serverproxy { $domain:
    listen  => '81',
    proxyto => "http://localhost:${port}",
  }
}
