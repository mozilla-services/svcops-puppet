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
      target  => "/usr/share/zoneinfo/${timezone}";

    '/etc/sysconfig/clock':
      ensure  => 'file',
      content => "ZONE=\"${timezone}\"\n",

  }
}
