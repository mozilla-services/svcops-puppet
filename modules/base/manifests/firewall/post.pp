# base firewall allows
class base::firewall::post(
  $default_rule = 'accept',
) {
  require base::firewall::pre

  firewall { '990 log subnet':
    chain      => 'SUBNET',
    jump       => 'LOG',
    log_prefix => 'SUBNET: ',
    proto      => 'all',
  }->
  firewall { '991 allow subnet':
    action     => $default_rule,
    chain      => 'SUBNET',
    proto      => 'all',
  }

  firewall { '990 log all':
    jump       => 'LOG',
    log_prefix => 'UNCAUGHT: ',
    proto      => 'all',
  }->
  firewall { '991 all default action':
    action     => $default_rule,
    proto      => 'all',
  }
}
