# Manage sysctl settings on web hosts
class base::sysctl::web {

  sysctl::value {
    'net.ipv4.tcp_max_syn_backlog':
      value => '100000';
    'net.core.somaxconn':
      value => '40960';
    'net.ipv4.tcp_wmem':
      value => '4096 87380 16777216';
    'net.ipv4.tcp_rmem':
      value => '4096 87380 16777216';
    'net.core.rmem_max':
      value => '16777216';
    'net.core.wmem_max':
      value =>'16777216';
    'net.ipv4.ip_local_port_range':
      value => '12000 64000';
  }
}
