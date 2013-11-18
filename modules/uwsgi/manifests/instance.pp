# uwsgi instance.
define uwsgi::instance(
    $app_dir,
    $appmodule,
    $port,
    $user,
    $home = undef, # point at venv
    $workers = 4,
    $environ = '',
    $log_syslog = true,
    $use_unix_socket = true,
    $scl = undef
) {
    include uwsgi

    $app_name = $name
    $upstream_name = "uwsgi_${app_name}"
    $pid_file = "${uwsgi::pid_dir}/${app_name}.pid"
    $sock_file = "${uwsgi::pid_dir}/${app_name}.sock"

    if $scl {
        $command = "/usr/bin/scl ${scl} '/usr/bin/uwsgi ${uwsgi::conf_dir}/${app_name}.ini'"
    } else {
        $command = "/usr/bin/uwsgi ${uwsgi::conf_dir}/${app_name}.ini"
    }

    file {
        "${uwsgi::conf_dir}/${app_name}.ini":
            require => Class['uwsgi'],
            content => template('uwsgi/uwsgi.ini');
    }

    supervisord::service {
        "uwsgi-${app_name}":
            require         => File["${uwsgi::conf_dir}/${app_name}.ini"],
            command         => "/usr/bin/uwsgi ${uwsgi::conf_dir}/${app_name}.ini",
            app_dir         => '/tmp',
            environ         => $environ,
            stopsignal      => 'INT',
            restart_command => "/bin/kill -HUP $(cat ${pid_file})",
            user            => $user;
    }

    exec {
        "fix_uwsgi_${app_name}_perms":
            require => Supervisord::Service["uwsgi-${app_name}"],
            unless  => "/usr/bin/test $(stat -c %a \"${sock_file}\") = 666",
            command => "/bin/chmod 666 ${sock_file}";
    }

    if $use_unix_socket {
        nginx::upstream_unix {
            $upstream_name:
                upstream_file => $sock_file;
        }
    } else {
        nginx::upstream {
            $upstream_name:
                upstream_host => '127.0.0.1',
                upstream_port => $port;
        }
    }

    motd {
        "2-uwsgi-${app_name}":
            order   => 12,
            content => "    ${app_name} is hosted at uwsgi://127.0.0.1:${port}/,unix:${sock_file} (${app_dir})\n";
    }
}
