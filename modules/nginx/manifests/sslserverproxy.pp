# create a location / in a vhost that proxies somewhere else.
define nginx::sslserverproxy(
  $proxyto, # http://testhost
  $ssl_key,
  $ssl_certificate
) {
  $server_name = $name
  nginx::config {
    $server_name:
      content => template('nginx/sslserverproxy.conf');
  }
}
