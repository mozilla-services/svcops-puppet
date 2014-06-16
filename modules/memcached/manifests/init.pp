# memcached class
class memcached (
  $max_connections = '10024',
  $max_threads = undef,
  $port = '11211',
  $size = '',
  $version = 'present',
) {

  if $max_threads {
    $threads = $max_threads
  }
  else {
    $threads = $::processorcount - 1
  }

  if $size == '' {
    $cachesize = inline_template('<%= @memorysize =~ /^(\d+)/; val = ( ( $1.to_i * 1024) / 1.05 ).to_i %>')
  }
  else {
    $cachesize = $size
  }

  $memlock_size = ($cachesize + 64) * 1024

  $limits_config =  {
    'memcached-soft' => {
      'domain'       => 'nobody',
      'type'         => 'soft',
      'item'         => 'memlock',
      'size'         => $memlock_size
    },
    'memcached-hard' => {
      'domain'       => 'nobody',
      'type'         => 'hard',
      'item'         => 'memlock',
      'size'         => $memlock_size
    },
  }

  limits {
    'memcached':
      config => $limits_config,
  }


  package {
    'memcached':
      ensure => $version;
  }

  package {
    'perl-Cache-Memcached':
      ensure => 'installed',
  }

  service {
    'memcached':
      ensure  => 'running',
      enable  => true,
      require => [
        Package[memcached],
        Limits['memmcached'],
      ],
  }

  file {
    '/etc/sysconfig/memcached':
      ensure  => 'file',
      notify  => Service['memcached'],
      content => template('memcached/memcached'),
      require => Package[memcached];
  }
}
