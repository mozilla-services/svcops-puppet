# sets system timezone.
class timezone(
  $timezone = 'UTC'
){

  package {
    'tzdata':
      ensure => 'installed';
  }

  file {
    '/etc/localtime':
      require => Package['tzdata'],
      target  => "/usr/share/zoneinfo/${timezone}",
  }

  file {
    '/etc/sysconfig/clock':
      ensure  => 'file',
      content => "ZONE=\"${timezone}\"\n",
      require => Package['tzdata'],
      notify  => Exec['tzdata-update'],
  }

  exec {
    'tzdata-update':
      command     => '/usr/sbin/tzdata-update',
      refreshonly => true,
      logoutput   => 'on_failure',
      require     => Package['tzdata'],

  }
}
