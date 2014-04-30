class audit::debian {
    case $::operatingsystemrelease {
        /^(12\.|3.2.0-36-virtual)/: {
            $audit_lib = 'libaudit0'
            $audit_package = '1.7.18-1ubuntu1'

            package {
                'system-config-audit':
                    ensure => $audit_package;
            }
        }

        /^13\./: {
            $audit_lib = 'libaudit1'
            $audit_package = '1:2.2.2-1ubuntu4'
        }

        default: {
            fail("Audit doesn't support $::operatingsystemrelease")
        }
    }

    package {
        # auditd dependencies
        [
            'libprelude2',
            'python-glade2',
            'menu',
        ]:
            ensure => latest;
    }

    package {
        'audisp-cef':
            # We would say 1.3 here, but there are complications.
            # So for now, 'present' is enough. [#997387]
            ensure => present,
            require => Package[$audit_lib];
    }

    package {
        'audit_package':
            ensure => $audit_package,
            name   => 'auditd';

        [
            $audit_lib,
            'libaudit-dev',
            'python-audit',
            'audispd-plugins'
        ]:
            ensure => $audit_package;
    }
}
