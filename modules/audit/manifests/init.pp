class audit {
    case $::osfamily {
        "Debian": {
            include audit::debian
        }

        "RedHat": {
            case $::operatingsystemrelease {
                /^5/: {
                    include audit::rhel5
                }

                /^(6|2013.03)/: {
                    include audit::rhel6
                }
            }
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

    exec {
        'restart-auditd-for-audisp-cef':
            path    => '/usr/sbin:/sbin:/usr/local/sbin:/usr/bin:/bin:/usr/local/bin',
            command => 'service auditd restart',
            unless  => 'pidof audisp-cef',
            require => Service['auditd'];
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
}
