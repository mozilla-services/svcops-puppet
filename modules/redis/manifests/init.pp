# redis base class.
class redis(
  $version = 'latest'
){

  package {
    'redis':
      ensure => $version,
  }
  file {
    '/var/redis':
      ensure  => directory,
      require => Package['redis'],
      owner   => redis;

    '/etc/redis':
      ensure  => directory,
      require => Package['redis'],
      purge   => true;

    # Delete default init script.
    '/etc/init.d/redis':
      ensure  => absent,
      require => Package['redis'];

    '/usr/local/bin/redis_ganglia.py':
      mode    => '0755',
      require => Package['redis'],
      source  => 'puppet:///modules/redis/redis_ganglia.py';

    '/var/run/redis':
      ensure  => directory,
      require => Package['redis'],
      owner   => redis,
      group   => redis;
    '/var/log/redis':
      ensure  => directory,
      require => Package['redis'],
      owner   => redis,
      group   => redis;
  }

  user {
    'redis':
      comment => 'Redis',
      home    => '/var/lib/redis',
      shell   => '/bin/false',
  }
}
