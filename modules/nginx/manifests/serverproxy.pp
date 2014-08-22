# create a location / in a vhost that proxies somewhere else.
define nginx::serverproxy(
  $proxyto, # http://testhost

  $listen = '80',
  $ssl_proxy = false,
) {
  $server_name = $name
  nginx::config { $server_name:
    content => template('nginx/serverproxy.conf');
  }
}
