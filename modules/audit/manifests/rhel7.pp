# audit::rhel7
class audit::rhel7 {
  package {
    'audit_package':
      ensure  => '2.3.3-4.el7',
      name    => 'audit',
      notify  => Service['auditd'];

    'audit-libs-python':
      ensure  => '2.3.3-4.el7',
      notify  => Service['auditd'],
      require => Package['audit_package'];

    'audisp-cef':
      ensure  => '1.4-1',
      notify  => Service['auditd'],
      require => Package['audit_package'];

    'audispd-plugins':
      ensure  => '2.3.3-4.el7',
      notify  => Service['auditd'],
      require => Package['audit_package'];
  }

}
