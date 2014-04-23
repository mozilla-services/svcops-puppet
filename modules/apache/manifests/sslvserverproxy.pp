# set up a ssl vserver with a proxy.
define apache::sslvserverproxy(
  $proxyto,
  $ssl_key,
  $ssl_certificate,
) {
  $server_name = $name
  apache::config {
    $server_name:
      content => template('apache/sslvserverproxy.conf');
  }
}
