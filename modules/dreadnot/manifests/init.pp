# installs dreadnot
class dreadnot(
  $version = '0.1.4-2.2360aa1aa6',
  $root = '/opt/dreadnot'
){
  include dreadnot::plugins

  $instance_root = "${root}/instances"

  package { 'dreadnot':
    ensure => $version,
  }
  file {
    $instance_root:
      ensure  => directory,
      require => Package['dreadnot'],
      purge   => true,
      recurse => true;

    '/var/dreadnot':
      ensure => directory;
  }
}
