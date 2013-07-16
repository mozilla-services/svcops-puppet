# defines two gunicorns, a and b, that are the same
define gunicorn::set (
    $porta,
    $portb,
    $appmodule,
    $appdir,
    $gunicorn = '/usr/bin/gunicorn',
    $workers = '4', # this should be even
    $worker_class = 'sync',
    $max_requests = '5000',
    $timeout = '30',
    $environ = '',
    $user = 'nginx'
) {

    $set_name = $name

    $instance_workers = $workers / 2

    nginx::config {
        "upstream_${set_name}":
            content => "upstream gunicorn_${set_name} { server 127.0.0.1:${porta} fail_timeout=0; server 127.0.0.1:${portb} fail_timeout=0; }\n";
    }

    gunicorn::instance {
        "${set_name}-a":
            port           => $porta,
            appmodule      => $appmodule,
            appdir         => $appdir,
            gunicorn       => $gunicorn,
            workers        => $instance_workers,
            worker_class   => $worker_class,
            max_requests   => $max_requests,
            timeout        => $timeout,
            environ        => $environ,
            user           => $user,
            preload        => true,
            nginx_upstream => false;

        "${set_name}-b":
            port           => $portb,
            appmodule      => $appmodule,
            appdir         => $appdir,
            gunicorn       => $gunicorn,
            workers        => $instance_workers,
            worker_class   => $worker_class,
            max_requests   => $max_requests,
            timeout        => $timeout,
            environ        => $environ,
            preload        => true,
            user           => $user,
            nginx_upstream => false;
    }
}
