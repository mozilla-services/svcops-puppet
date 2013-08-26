# vim: set expandtab ts=2 sw=2 filetype=puppet syntax=puppet:
class circus::manager(
  $circus_package = 'circus',
  $circus_version = '0.8.1-1',
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
      notify  => Exec['circus-initctl-reload'],
  }

  # Our puppet doesn't have an upstart service provider, yet. Sigh.
  #service {
  #    'circusd':
  #        ensure  => running,
  #        enable  => true,
  #        require => [
  #            File['/etc/init/circusd.conf'],
  #            File['/etc/circus.ini'],
  #        ];
  #}

  exec {
    'circusd-initctl-start':
      command => '/sbin/initctl start circusd',
      unless  => '/sbin/initctl status circusd | grep -w running',
      require => [
        Package[$circus_package],
        File['/etc/init/circusd.conf'],
        File['/etc/circus.ini'],
      ];
    'circus-initctl-reload':
      command     => '/sbin/initctl restart circusd',
      refreshonly => true;
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
      notify  => Exec['circus-initctl-reload'];
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
