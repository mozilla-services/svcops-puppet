# describe flightdeck on a webserver.
define marketplace::apps::flightdeck::web_instance(
    $gunicorn_name,
    $port,
    $app_dir,
    $gunicorn = '/usr/bin/gunicorn',
    $appmodule = 'wsgi.flightdeck:application',
    $workers = '4'
    $worker_class = 'sync',
    $timeout = '90',
    $environ = ''
) {
    $app_name = $name
    gunicorn::instance {
        $gunicorn_name:
            gunicorn  => $gunicorn,
            port      => $port,
            workers   => $workers,
            appmodule => $appmodule,
            timeout   => $timeout,
            environ   => $environ,
            appdir    => $app_dir;
    }
}
