# Manage sysctl settings on web hosts
class base::sysctl::web {

    sysctl::value {
        'net.ipv4.tcp_max_syn_backlog':
            value => '16384';
        'net.core.somaxconn':
            value => '8192';
        'net.ipv4.tcp_wmem':
            value => '8192 873800 8738000';
        'net.ipv4.tcp_rmem':
            value => '8192 873800 8738000';
        'net.core.rmem_max':
            value => '8388608';
        'net.core.wmem_max':
            value =>'8388608';
    }
}
