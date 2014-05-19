# monolith web firewall
class marketplace::apps::monolith::web::firewall {
  include firewall
  firewall {
    '100 allow established/related':
      action  => 'accept',
      ctstate => ['ESTABLISHED', 'RELATED'],
      proto   => 'all';

    '110 allow ICMP':
      action => 'accept',
      proto  => 'icmp';

    '120 allow lo':
      action  => 'accept',
      iniface => 'lo',
      proto   => 'all';

    '200 allow ssh':
      action => 'accept',
      dport  => '22';

    '201 allow http':
      action => 'accept',
      dport  => ['80-81'];

    '300 log input':
      jump       => 'LOG',
      log_prefix => 'WILLDROP: ',
      proto      => 'all';
  }
}
