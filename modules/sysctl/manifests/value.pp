define sysctl::value (
    $value,
    $key = 'name'
) {

    $val1 = $value

    $real_key = $key ? {
        'name'  => $name,
        default => $key,
    }

    sysctl { $real_key :
        val    => $val1,
        before => Exec["exec_sysctl_${real_key}"],
    }

    $command = $::kernel ? {
        openbsd => "sysctl ${real_key}=\"${val1}\"",
        default => "sysctl -w ${real_key}=\"${val1}\"",
    }

    $unless = $::kernel ? {
        openbsd => "sysctl ${real_key} | grep -q '=${val1}\$'",
        default => "sysctl ${real_key} | grep -q ' = ${val1}'",
    }

    exec { "exec_sysctl_${real_key}" :
        path    => ['/sbin', '/bin'],
        command => $command,
        unless  => $unless,
        require => Sysctl[$real_key],
    }

    augeas {
        $real_key:
            context => '/files/etc/sysctl.conf',
            changes => "set ${real_key} ${val1}",
    }

}
