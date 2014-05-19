# base firewall allows
class base::firewall::pre(
  $host_network = '127.0.0.1/32' # e.g., 192.168.1.0/24
) {
  include firewall

  resources { 'firewall':
    purge => true,
  }

  firewallchain { 'SUBNET:filter:IPv4':
    ensure => 'present',
    purge  => true,
  }->
  firewall { '490 log subnet':
    chain      => 'SUBNET',
    jump       => 'LOG',
    log_prefix => 'SUBNET: ',
    proto      => 'all',
  }->
  firewall { '491 allow subnet':
    action     => 'accept',
    chain      => 'SUBNET',
    proto      => 'all',
  }

  firewall { '100 allow established/related':
    action  => 'accept',
    ctstate => ['ESTABLISHED', 'RELATED'],
    proto   => 'all',
  }->
  firewall { '110 allow ICMP':
    action => 'accept',
    proto  => 'icmp',
  }->
  firewall { '120 allow lo':
    action  => 'accept',
    iniface => 'lo',
    proto   => 'all',
  }->
  firewall { '130 allow mcast':
    action  => 'accept',
    pkttype => 'multicast',
    proto   => 'all',
  }->
  firewall { '150 subnet jump':
    jump    => 'SUBNET',
    proto   => 'all',
    source  => $host_network,
  }->
  firewall { '200 allow ssh':
    action => 'accept',
    dport  => '22',
  }
}
