# packages required by pushgo.
class pushgo::packages {
  package {
    'libmemcached':
      ensure => '1.0.16-1.el6';
  }
}
