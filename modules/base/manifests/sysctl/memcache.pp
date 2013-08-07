# Manage sysctl settings on memcache hosts
class base::sysctl::memcache {

    sysctl::value {
        'net.ipv4.tcp_max_syn_backlog':
            value => '16384';
        'net.core.somaxconn':
            value => '8192';
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
    }
}
