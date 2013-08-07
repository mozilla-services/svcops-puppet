# class for netvault backups
class netvault (
    $netvault_ports = undef,
    $netvault_password = hiera('netvault_password'),
    $netvault_excludes = undef
    ) {

    package {
        'netvault-installer':
            ensure => latest;
    }
    if $::architecture == 'x86_64' and $::virtual == 'vmware' {
        package {
            'glibc.i686':
                ensure => latest,
                before => Package['netvault-installer'];
        }
    }

    file {
        'answers':
            path    => '/usr/share/netvault-installer/answers.txt',
            content => template('netvault/answers.txt.erb'),
            require => Package['netvault-installer'];

        '/usr/netvault/config/firewall.cfg':
            content => template('netvault/firewall.cfg.erb'),
            require => Exec['install-netvault'],
            notify  => Service['netvault'];
        }
    if $netvault_excludes != undef {
        file {
                '/usr/netvault/config/excludes.cfg':
                content => template('netvault/excludes.cfg.erb'),
                require => Exec['install-netvault'],
                notify  => Service['netvault'];
            }
    }

    exec {
        'install-netvault':
            cwd         => '/usr/share/netvault-installer/',
            command     => '/usr/share/netvault-installer/install answers.txt',
            require     => File['answers'],
            refreshonly => true,
            subscribe   => Package['netvault-installer'];
    }

    service {
        'netvault':
            ensure     => running,
            enable     => true,
            hasstatus  => false,
            hasrestart => false,
            status     => 'ps xa |grep netvault |grep -v grep',
            require    => Exec['install-netvault'];
    }

}
