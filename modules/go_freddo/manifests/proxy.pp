# proxy to freddo
class go_freddo::proxy(
  $hostname = 'freddo.allizom.org',
  $freddo_url = 'http://localhost:8882'
) {
  nginx::serverproxy { $hostname:
    listen  => 81,
    proxyto => $freddo_url,
  }
}
