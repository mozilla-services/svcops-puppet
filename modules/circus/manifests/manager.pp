# vim: set expandtab ts=2 sw=2 filetype=puppet syntax=puppet:
class circus::manager(
  $circus_package = 'circus',
  $circus_version = '0.9.2-1',
  $endpoint = 'tcp://127.0.0.1:5555',
  $pubsub_endpoint = undef,
  $statsd = undef,
  $stats_endpoint = undef,
  $statsd_close_outputs = undef,
  $check_delay = 5,
  # $include = undef,
  # $include_dir = undef,
  $stream_backend = undef,
  $warmup_delay = undef,
  $httpd = undef,
  $httpd_host = undef,
  $httpd_port = undef,
  $httpd_close_outputs = undef,
  $debug = undef,
  $pidfile = undef,
  $loglevel_ = undef, # avoid metaparameter collision
  $logoutput = undef,
){
  $base_dir = '/etc/circus.d'
  $hooks_module = 'hooks'
  $hooks_dir = "${base_dir}/${hooks_module}"

  package {
    $circus_package:
      ensure  => $circus_version,
      alias   => 'circus',
      notify  => Service['circusd'];
  }

  service {
    'circusd':
      ensure   => running,
      enable   => true,
      start    => '/sbin/initctl start circusd',
      restart  => '/sbin/initctl restart circusd',
      stop     => '/sbin/initctl stop circusd',
      status   => '/sbin/initctl status circusd | /bin/grep -qw running',
      provider => 'base',
      require  => [
        Package[$circus_package],
        File['/etc/init/circusd.conf'],
        File['/etc/circus.ini'],
      ];
  }

  File {
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }

  file {
    '/etc/init/circusd.conf':
      source  => 'puppet:///modules/circus/circusd.conf';
    '/etc/circus.ini':
      content => template('circus/circus.ini'),
      notify  => Service['circusd'];
    $base_dir:
      ensure  => directory,
      mode    => '0755';
    $hooks_dir:
      ensure  => directory,
      mode    => '0755';
    "${hooks_dir}/__init__.py":
      ensure  => present,
  }
}
