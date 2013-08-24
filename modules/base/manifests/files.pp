# base files
class base::files {

  @file {
    '/data':
      ensure  => directory,
      path    => '/data';

    '/data/logs':
      ensure => directory;
    '/root/bin':
      ensure => directory;
  }
}
