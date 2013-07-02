class audit {
    case $::osfamily {
        "Debian": {
            include audit::debian
        }
        "RedHat": {
            include audit::rhel
        }
        default: { }
    }

    service {
        'auditd':
            ensure => running,
            enable => true,
            require => Package['audit_package'],
            hasstatus => true;
    }

    file {
        '/etc/audit/auditd.conf':
            ensure => file,
            require => Package['audit_package'],
            notify => Service['auditd'],
            owner => "root",
            group => "root",
            mode => '0600',
            source => "puppet:///modules/audit/auditd.conf";

        '/etc/audit/audit.rules':
            ensure => file,
            require => Package['audit_package'],
            notify => Service['auditd'],
            owner => "root",
            group => "root",
            mode => '0600',
            content => template("audit/audit.rules.erb");

        '/etc/audisp/audispd.conf':
            ensure => file,
            require => Package['audit_package'],
            notify => Service['auditd'],
            owner => "root",
            group => "root",
            mode => '0600',
            source => "puppet:///modules/audit/audispd.conf";

        '/etc/audisp/plugins.d/syslog.conf':
            ensure  => file,
            require => Package['audit_package'],
            notify  => Service['auditd'],
            owner   => root,
            group   => root,
            mode    => '0600',
            source  => "puppet:///modules/audit/syslog.conf";

        '/var/log/audit':
            ensure => directory,
            owner  => root,
            group  => root,
            mode   => '0700';
    }
    exec {
        'restart-auditd':
            path    => '/bin:/usr/bin:/sbin:/usr/sbin',
            command => '/etc/init.d/auditd restart',
            onlyif  => "auditctl -s | grep 'pid=0\\|enabled=0' || if [ $(pidof audisp-cef) ]; then false; else true; fi";
    }
}
