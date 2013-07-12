class nfsclient {

    realize(Nrpe::Plugin["nfs_mounts"])

    package {
        'nfs-utils':
            ensure => 'latest';
    }

    service {
        'nfs':
            enable => true,
            ensure => "running",
            hasstatus => true,
            require => Package['nfs-utils'];

        'nfslock':
            enable => true,
            ensure => "running",
            before => Service['nfs'],
            hasstatus => true,
            require => Package['nfs-utils'];
    }

    if $operatingsystemrelease =~ /^6/ {

        service {
            'rpcbind':
                enable => true,
                ensure => "running",
                before => Service['nfslock'],
                hasstatus => true,
                require => Package['nfs-utils'];
        }
    }
}
