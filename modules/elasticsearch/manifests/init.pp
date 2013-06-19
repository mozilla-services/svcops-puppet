# elasticsearch class
class elasticsearch (
    $version = 'present',
    $package = 'elasticsearch',
    $java_package = 'java-1.7.0-openjdk',
    $config_dir = '/etc/elasticsearch',
    $user = elasticsearch,
    $plugins = ['elasticsearch-plugin-site-head']
){

  package {
    $package:
        ensure  => $version;
  }

  package {
    $java_package:
        ensure => present,
        before => Package[$package];
  }

  service { 'elasticsearch':
      ensure  => running,
      enable  => true,
      require => Package[$package];
  }

  if $plugins {
      class {
          'elasticsearch::plugins':
              require => Package[$package];
      }
  }
}
