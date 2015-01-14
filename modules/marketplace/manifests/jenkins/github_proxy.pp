define marketplace::jenkins::github_proxy(
  $listen,
  $proxyto,
) {
  $server_name = $name

  nginx::config { $server_name:
    content => template('marketplace/nginx/jenkins_github_proxy.conf'),
  }->
  nginx::config { 'github':
    content => template('marketplace/nginx/github.users'),
    suffix  => '.users',
  }
}
