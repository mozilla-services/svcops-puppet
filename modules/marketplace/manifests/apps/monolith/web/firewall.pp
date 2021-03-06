# monolith web firewall
class marketplace::apps::monolith::web::firewall {
  require base::firewall::pre
  include base::firewall::post

  Firewall {
    before => Class['base::firewall::post'],
  }

  firewall { '400 allow subnet http':
    action => 'accept',
    chain  => 'SUBNET',
    dport  => ['80-82'],
  }->
  firewall { '401 allow subnet ganglia':
    action => 'accept',
    chain  => 'SUBNET',
    dport  => '8649',
  }

  firewall { '300 allow http':
    action => 'accept',
    dport  => ['80-82'],
  }->
  firewall { '301 allow subnet ganglia':
    action => 'accept',
    dport  => '8649',
  }
}
