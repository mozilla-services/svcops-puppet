# Helper for creating "/var/log/nginx/<domainname>"
define nginx::logdir {
    file { "/var/log/nginx/${name}":
        ensure  => directory,
        require => Package['nginx'],
        before  => Service['nginx'],
        owner   => $nginx::nx_user,
        group   => 'root',
        mode    => '0755',
        purge   => true,
    }
}
