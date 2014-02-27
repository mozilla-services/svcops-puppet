# supervisor service
define supervisord::service(
    $command,
    $app_dir,
    $user,
    $priority = '999',
    $stopwaitsecs = '60',
    $environ = '',
    $configtest_command = '',
    $stopsignal = undef,
    $restart_command = undef
) {
    include supervisord::base

    $supervisor_name = $name
    $supervisor_user = $user
    if $restart_command {
        $_restart_command = $restart_command
    } else {
        $_restart_command = "/usr/bin/supervisorctl restart ${supervisor_name} |  awk '/^${supervisor_name}[: ]/{print \$2}' | grep '^stopped\nstarted$'"
    }
    file {
        "/etc/supervisord.conf.d/${name}.conf":
            require => File['/etc/supervisord.conf.d'],
            #notify  => Service['supervisord'],
            content => template('supervisord/supervisor.conf');

        "/etc/init.d/${name}":
            mode    => '0755',
            content => template('supervisord/init-supervisor');
    }
    service {
        $supervisor_name:
            ensure     => running,
            require    => File["/etc/init.d/${supervisor_name}", "/etc/supervisord.conf.d/${supervisor_name}.conf"],
            enable     => true,
            hasrestart => true,
            hasstatus  => true,
            restart    => $_restart_command,
            status     => "/usr/bin/supervisorctl status ${supervisor_name} | /bin/grep -q RUNNING";
    }
}
