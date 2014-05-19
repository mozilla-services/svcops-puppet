# monolith web firewall
class marketplace::apps::monolith::web::firewall {

  resources { 'firewall':
    purge => true,
  }

  include firewall
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
  firewall { '200 allow ssh':
    action => 'accept',
    dport  => '22',
  }->
  firewall { '201 allow http':
    action => 'accept',
    dport  => ['80-81'],
  }->
  firewall { '300 log input':
    jump       => 'LOG',
    log_prefix => 'WILLDROP: ',
    proto      => 'all',
  }
}
