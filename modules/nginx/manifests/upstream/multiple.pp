# adds support for multiple upstream proxy.
define nginx::upstream::multiple(
  $upstream = '127.0.0.1:80', ## list of addresses ['127.0.0.1:80','127.0.0.2:80']
  $keepalive = false,
  $keepalive_connections = '50'
) {
  $upstream_name = $name
  nginx::config {
    "upstream_${upstream_name}":
      content => template('nginx/upstream_multiple.conf')
  }
}
