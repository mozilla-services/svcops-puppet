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


  package {
    'memcached':
      ensure => $version;
  }

  package {
    'perl-Cache-Memcached':
      ensure => present;
  }

  service {
    'memcached':
      ensure  => running,
      enable  => true,
      require => Package[memcached];
  }

  file {
    '/etc/sysconfig/memcached':
      ensure  => present,
      notify  => Service['memcached'],
      content => template('memcached/memcached'),
      require => Package[memcached];
  }
}
