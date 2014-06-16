# install and configure nginx
class nginx(
  $enable_compression = false,
  $keepalive_timeout = 35,
  $nginx_conf = undef,
  $nx_user = 'nginx',
  $server_names_hash_bucket_size = undef,
  $version = 'present',
){
  realize(File['/data'], File['/data/logs'])

  $compression_ensure = enable_compression ? {
    true    => present,
    false   => absent,
    default => absent
  }

  package {
    'nginx':
      ensure  => $version;
  }

  service {
    'nginx':
      ensure     => running,
      require    => Package['nginx'],
      enable     => true,
      restart    => '/etc/init.d/nginx restart',
      status     => '/etc/init.d/nginx status',
      hasstatus  => true,
      hasrestart => true;
  }

  exec {
    'mv_old_nginx_logdir':
      before  => File['/var/log/nginx'],
      unless  => '/usr/bin/test ! -e /var/log/nginx || /usr/bin/test -L /var/log/nginx',
      command => '/bin/mv /var/log/nginx /var/log/nginx.old'
  }
  if $nginx_conf {
    $_nginx_conf = $nginx_conf
  } else {
    $_nginx_conf = template('nginx/nginx.conf')
  }

  file {
    # the absence of 'source => ...' tells puppet that we want to remove all unmanaged files from these directories.
    # TODO: Fix bug 811515 someday, so that unmanaged directories are removed as well.
    ['/etc/nginx/',
      '/etc/nginx/conf.d/',
      '/etc/nginx/managed/']:
      ensure  => directory,
      notify  => Service['nginx'],
      force   => true,
      recurse => true,
      purge   => true;

    '/data/logs/nginx':
      ensure  => directory,
      require => [File['/data/logs'], Package[nginx]],
      owner   => $nx_user,
      group   => 'users',
      mode    => '0750';

    '/var/log/nginx':
      ensure  => link,
      target  => '/data/logs/nginx',
      require => [
        Package[nginx],
        File['/data/logs/nginx'],
      ],
      owner   => $nx_user,
      group   => 'users',
      mode    => '0750';

    '/etc/nginx/nginx.conf':
      before  => Service[nginx],
      notify  => Service['nginx'],
      content => $_nginx_conf;

    '/etc/nginx/conf.d/managed.conf':
      before  => Service[nginx],
      content => "include managed/*.conf;\n";

    '/etc/nginx/mime.types':
      source => 'puppet:///modules/nginx/mime.types';

    '/etc/nginx/conf.d/hostname.conf':
      require => Package[nginx],
      before  => Service[nginx],
      content => "add_header X-Backend-Server ${::hostname};\n";

    '/etc/sysconfig/nginx':
      require => Package['nginx'],
      mode    => '0644',
      content => template('nginx/sysconfig/nginx');

    '/etc/logrotate.d/nginx':
      require => Package[nginx],
      owner   => $nx_user,
      group   => root,
      mode    => '0644',
      content => template('nginx/logrotate.conf');

    '/etc/init.d/nginx':
      require => Package[nginx],
      before  => Service[nginx],
      owner   => root,
      group   => root,
      mode    => '0755',
      source  => 'puppet:///modules/nginx/etc-init.d/nginx';
  }

  nginx::logdir { 'default': }

  file {
    '/etc/nginx/conf.d/compression.conf':
      ensure  => $compression_ensure,
      content => template('nginx/compression.conf'),
      notify  => Service['nginx'];
  }

}
