# memcached packages
class memcached::package(
  $version = 'installed'
){

  package {
    'memcached':
      ensure => $version;
  }

  package {
    'perl-Cache-Memcached':
      ensure => 'installed',
  }
}
