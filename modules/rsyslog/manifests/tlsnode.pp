define rsyslog::tlsnode(
    $rsyslog_ca_cert_content,
    $rsyslog_ca_cert = '/etc/pki/rsyslog/rsyslog-ca.crt'
) {
    $syslog_server = $name
    include rsyslog

    rsyslog::config {
        "tlsnode_${syslog_server}":
            content => template('rsyslog/tlsnode.conf');
    }

    file {
        "${rsyslog_ca_cert}":
             ensure  => present,
             mode    => '0644',
             content => $rsyslog_ca_cert_content,
             before  => Rsyslog::Config["tlsnode_${syslog_server}"],
    }
}
