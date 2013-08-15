class pushgo::sysctl {
    sysctl::value {
        'net.ipv4.ip_local_port_range':
            value => '2000 65000';
        'net.ipv4.tcp_window_scaling':
            value => '1';
        'net.ipv4.tcp_max_syn_backlog':
            value => '3240000';
        'net.core.somaxconn':
            value => '3240000';
        'net.ipv4.tcp_max_tw_buckets':
            value => '1440000';
        'net.core.rmem_default':
            value => '8388608';
        'net.core.rmem_max':
            value => '16777216';
        'net.core.wmem_max':
            value => '16777216';
        'net.ipv4.tcp_rmem':
            value => '4096 87380 16777216';
        'net.ipv4.tcp_wmem':
            value => '4096 65536 16777216';
    }
}
