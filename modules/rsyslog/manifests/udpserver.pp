class rsyslog::udpserver(
    $udp_port = 514
) {
    rsyslog::config {
        'udpserver':
            content => template('rsyslog/udpserver.conf');
    }
}
