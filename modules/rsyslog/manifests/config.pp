define rsyslog::config(
    $content
) {
    include rsyslog
    $config_name = $name
    file {
        "/etc/rsyslog.d/${config_name}.conf":
            notify => Service['rsyslog'],
            content => $content;
    }
}
