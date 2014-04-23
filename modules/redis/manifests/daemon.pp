# redis daemon
define redis::daemon(
  $port, $size,
  $config_name='redis.conf',
  $redis_slaveof_ip='', $redis_slaveof_port='',
  $redis_persistent=false,
  $memory_policy='volatile-lru',
  $bind='127.0.0.1',
  $client_output_buffer_limit_hard = '64mb',
  $client_output_buffer_limit_soft = '32mb',
  $maxclients=10000
) {
  service {
    "redis-${name}":
      ensure    => running,
      enable    => true,
      hasstatus => true,
      status    => "/etc/init.d/redis-${name} status";
  }

  file {
    "/var/redis/${name}":
      ensure  => directory,
      require => File['/var/redis'],
      owner   => redis;

    "/etc/redis/${name}.conf":
      require => File['/etc/redis'],
      content => template("redis/${config_name}");

    "/etc/init.d/redis-${name}":
      mode    => '0755',
      content => template('redis/redis.init');
  }
}
