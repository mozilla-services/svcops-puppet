# describe flightdeck on a webserver.
define marketplace::apps::flightdeck::web_instance(
    $gunicorn_name,
    $port,
    $app_dir,
    $server_names,
    $gunicorn = '/usr/bin/gunicorn',
    $appmodule = 'wsgi.flightdeck:application',
    $workers = '4',
    $worker_class = 'sync',
    $timeout = '90',
    $environ = ''
) {
    $config_name = $name
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
    marketplace::nginx::flightdeck {
        $config_name:
            server_names => $server_names,
            webroot      => $app_dir
    }
}
