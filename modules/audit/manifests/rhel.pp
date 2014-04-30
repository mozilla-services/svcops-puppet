class audit::rhel {
  package {
    'audit_package':
      ensure => 'present',
      name   => 'audit-mozilla',
      notify => Service['auditd'];
    'audispd-mozilla-plugins':
      ensure => 'present',
      notify => Service['auditd'];
    'audit-mozilla-libs-python':
      ensure  => 'present',
      notify  => Service['auditd'],
      require => [ Package['audit_package'], Package['audit-mozilla-libs'] ];
    'audit-mozilla-libs':
      ensure => 'present',
      notify => Service['auditd'],
      before => Package['audit_package'];
  }

}
