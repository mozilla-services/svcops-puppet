class audit::rhel {
  package {
    'audit_package':
      ensure => 'latest',
      name   => 'audit-mozilla',
      notify => Service['auditd'];
    'audispd-mozilla-plugins':
      ensure => 'latest',
      notify => Service['auditd'];
    'audit-mozilla-libs-python':
      ensure => 'latest',
      notify => Service['auditd'],
      require => [ Package['audit_package'], Package['audit-mozilla-libs'] ];
    'audit-mozilla-libs':
      ensure => 'latest',
      notify => Service['auditd'],
      before => Package['audit_package'];

    'audit':
      ensure => absent,
      before => Package['audit_package'];
    'audispd-plugins':
      ensure => absent,
      before => Package['audispd-mozilla-plugins'];
    'audit-libs-python':
      ensure => absent;
#        'audit-libs':
#            ensure => absent,
#            notify => Service['auditd'],
#            before => Package['audit-mozilla-libs'];
    'audispd-plugins-1.8-3.el5.centosmoz5.i386':
      ensure => absent;
  }

}
