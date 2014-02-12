# base sentry class
class sentry {
  package {
    'sentry':
      ensure => '6.4.4-1';
    'python-eventlet':
      ensure => 'latest';
  }
  file {
    '/etc/sentry.d':
      ensure  => 'directory',
      recurse => true,
      purge   => true;
  }
}
