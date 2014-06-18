# memcached multi_instance
define memcached::multi_instance (
  $cachesize,
  $port,
  $max_connections = '20048',
  $threads = '12',
) {

  include memcached::package

  file {
    "/etc/sysconfig/memcached_${port}":
      ensure  => 'file',
      notify  => Service['memcached'],
      content => template('memcached/memcached');

    "/etc/init.d/memcached_${port}":
      ensure  => 'file',
      content => template('memcached/init.d/memcached'),
      mode    => '0755';
  }

  service {
    "memcached_${port}":
      ensure  => 'running',
      enable  => true,
      require => [
        Class['memcached::package'],
        File["/etc/init.d/memcached_${port}"],
        File["/etc/sysconfig/memcached_${port}"],
      ],
  }
}
