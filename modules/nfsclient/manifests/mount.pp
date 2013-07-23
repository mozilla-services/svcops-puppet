# nfs client mount
define nfsclient::mount($host, $path, $rw,
        $add_to_hosts=true,
        $mkdir=true,
        $options='hard,nointr,rsize=65536,wsize=65536,bg,proto=tcp,vers=3,noatime',
        $ensure = mounted
) {
    include nfsclient

    $rw_opt = $rw ? {
        true  => "rw",
        false => "ro"
    }

    if ($add_to_hosts) {
        # add the host to /etc/hosts, based on DNS, if it's a hostname
        # Allow an opt-out here since NetApp C-mode is better off doing DNS
        if ($host !~ /^\d+\.\d+\.\d+\.\d+$/) {
            network::host {
                $host: ;
            }
        }
    }

    # add a file resource for the mountpoint, if desired;
    # also make a /mnt/netapp for free if the mount is a subdirectory of that
    if ($mkdir) {
        if ($title =~ /^\/mnt\/netapp/) {
            include nfsclient::mnt_netapp
        }
        file {
            $title:
                ensure => directory;
        }
    }

    mount {
        $title:
            ensure => $ensure,
            atboot => true,
            device => "${host}:${path}",
            options => "${rw_opt},${options}",
            fstype => "nfs",
            require => [ File[$title], Class['nfsclient'] ];
    }
}
