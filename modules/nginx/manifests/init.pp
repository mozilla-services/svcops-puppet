# install and configure nginx
class nginx(
    $nx_user = 'nginx',
    $version = 'present',
    $enable_compression = false
){

    realize(Yumrepo['nginx'])

    package {
        'nginx':
            ensure  => $version,
            require => Yumrepo['nginx'];
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
            require => Package[nginx],
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
            content => template('nginx/nginx.conf');

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

    if $enable_compression {
        file {
            '/etc/nginx/conf.d/compression.conf':
                ensure  => present,
                content => template('nginx/compression.conf'),
                notify  => Service['nginx']
        }
    }

}
