# supervisor service
define supervisord::service(
    $command,
    $app_dir,
    $user,
    $priority = '999',
    $stopwaitsecs = '60',
    $environ = '',
    $configtest_command = ''
) {
    include supervisord::base

    $supervisor_name = $name
    $supervisor_user = $user
    file {
        "/etc/supervisord.conf.d/${name}.conf":
            require => File['/etc/supervisord.conf.d'],
            notify  => Service['supervisord'],
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
            status     => "/sbin/service ${supervisor_name} status";
    }
}
