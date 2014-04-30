# audit::rhel6
class audit::rhel6 {
  package {
    'audit_package':
      ensure  => '2.2-2.el6',
      name    => 'audit',
      notify  => Service['auditd'],
      require => Exec['upgrade-auditd'];

    'audit-libs-python':
      ensure  => '2.2-2.el6',
      notify  => Service['auditd'],
      require => Package['audit_package'];

    'audisp-cef':
      ensure  => '1.3-1',
      notify  => Service['auditd'],
      require => Package['audit_package'];

    'audispd-plugins':
      ensure  => '2.2-2.el6',
      notify  => Service['auditd'],
      require => Package['audit_package'];
  }

  file {
    '/usr/local/libexec/upgrade-auditd':
      ensure => 'present',
      mode   => '0755',
      source => 'puppet:///modules/audit/upgrade-auditd';

    '/usr/local/libexec/audit-yum-transaction-bug-969740.txt':
      ensure => 'present',
      mode   => '0644',
      source => 'puppet:///modules/audit/audit-yum-transaction-bug-969740.txt';
  }

  exec {
    'upgrade-auditd':
      command => '/usr/local/libexec/upgrade-auditd',
      onlyif  => '/bin/rpm -q audit-mozilla',
      require => [ File['/usr/local/libexec/upgrade-auditd'], File['/usr/local/libexec/audit-yum-transaction-bug-969740.txt'] ];
  }
}
