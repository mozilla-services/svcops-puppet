# monolith web firewall
class marketplace::apps::monolith::web::firewall {
  require base::firewall::pre

  firewall { '201 allow http':
    action => 'accept',
    dport  => ['80-81'],
  }->
  firewall { '990 log input':
    jump       => 'LOG',
    log_prefix => 'WILLDROP: ',
    proto      => 'all',
  }
}
