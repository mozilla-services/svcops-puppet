# defines gunicorn instance.
define gunicorn::instance (
    $port,
    $appmodule,
    $appdir,
    $gunicorn = '/usr/bin/gunicorn',
    $workers = '4',
    $worker_class = 'sync',
    $max_requests = '5000',
    $timeout = '30',
    $environ = '',
    $nginx_upstream = true,
    $user = 'nginx',
    $preload = false
) {
    include gunicorn
    include supervisord::base

    $app_name = $name

    if($nginx_upstream) {
        nginx::upstream {
            "gunicorn_${app_name}":
                upstream_host => '127.0.0.1',
                upstream_port => $port;
        }
    }

    if $preload {
        $_preload = "--preload"
    } else {
        $_preload = ""
    }

    supervisord::service {
        "gunicorn-${app_name}":
            command            => "${gunicorn} -b 127.0.0.1:${port} ${_preload} -w ${workers} -k ${worker_class} -t ${timeout} --max-requests ${max_requests} -n gunicorn-${app_name} ${appmodule} --log-file /var/log/gunicorn/${user}-${app_name}",
            app_dir            => $appdir,
            environ            => $environ,
            configtest_command => "cd ${appdir}; ${gunicorn} --check-config ${appmodule}",
            user               => $user;
    }

    motd {
        # this is intended to follow 20-gunicorn in webapp::gunicorn
        "1-gunicorn-${app_name}":
            order   => '11',
            content => "    ${app_name} is hosted at http://127.0.0.1:${port}/ (${appdir})\n";
    }
}
