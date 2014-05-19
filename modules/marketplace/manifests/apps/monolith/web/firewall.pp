# monolith web firewall
class marketplace::apps::monolith::web::firewall {
  include firewall
  firewall { '100 log input':
    jump       => 'LOG',
    log_prefix => 'IN: ',
    proto      => 'all',
  }

}
