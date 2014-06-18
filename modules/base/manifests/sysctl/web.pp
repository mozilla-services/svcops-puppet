# Manage sysctl settings on web hosts
class base::sysctl::web {

  modprobe::persistent {
    'tcp_htcp':;
  }

  sysctl::value {
    'net.ipv4.tcp_max_syn_backlog':
      value => '100000';

    'net.core.netdev_max_backlog':
      value => '60000';

    'net.ipv4.tcp_congestion_control':
      value   => 'htcp',
      require => Modprobe::Persistent['tcp_htcp'];

    'net.core.somaxconn':
      value => '40960';

    'net.ipv4.tcp_wmem':
      value => '8192 873800 16777216';

    'net.ipv4.tcp_rmem':
      value => '8192 873800 16777216';

    'net.core.rmem_max':
      value => '16777216';

    'net.core.wmem_max':
      value => '16777216';

    'net.core.wmem_default':
      value => '65536';

    'net.core.rmem_default':
      value => '65536';

    'net.ipv4.tcp_tw_reuse':
      value => '1';

    'net.ipv4.tcp_fin_timeout':
      value => '15';

    'net.ipv4.tcp_syncookies':
      value => '0';

    'net.ipv4.tcp_keepalive_time':
      value => '120';

    'net.ipv4.tcp_keepalive_intvl':
      value => '40';

    'net.ipv4.tcp_keepalive_probes':
      value => '20';

    'net.ipv4.ip_local_port_range':
      value => '12000 64000';
  }
}
