class audit::debian {

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
    'audit_package':
      ensure => '1.7.18-1ubuntu1moz2',
      name   => 'auditd';

    [
      'libaudit-dev',
      'libaudit0',
      'python-audit',
      'system-config-audit',
      'audispd-plugins'
    ]:
      ensure => '1.7.18-1ubuntu1moz2';
  }

}
