# defines newrelic sysmond
class marketplace::newrelic::sysmond(
  $license_key = ''
){
  realize(Yumrepo['newrelic'])

  package {
    'newrelic-sysmond':
      ensure => present;
  }

  file {
    '/etc/newrelic/nrsysmond.cfg':
      content => template('marketplace/newrelic/nrsysmond.cfg');
  }

  service { 'newrelic-sysmond':
    ensure    => running,
    subscribe => File['/etc/newrelic/nrsysmond.cfg'],
  }

  Yumrepo['newrelic'] -> Package['newrelic-sysmond'] -> File['/etc/newrelic/nrsysmond.cfg'] -> Service['newrelic-sysmond']

}
