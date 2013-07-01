define rsyslog::udpnode() {
    $syslog_server = $name
    include rsyslog

    rsyslog::config {
        "udpnode_${syslog_server}":
            content => template('rsyslog/udpnode.conf');
    }
}
