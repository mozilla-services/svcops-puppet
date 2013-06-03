# define zamboni instance.
define marketplace::apps::zamboni(
    $gunicorn_name,
    $port,
    $app_dir,
    $appmodule = 'wsgi.zamboni:application',
    $workers = 12,
    $worker_class = 'sync',
    $timeout = '90',
    $environ = '',
    $newrelic_license_key = ''
) {
    $app_name = $name
    $gunicorn = "${app_dir}/venv/bin/gunicorn"

    if $newrelic_license_key {
        marketplace::newrelic::python {
            $app_name:
                before      => Gunicorn::Instance[$gunicorn_name],
                license_key => $newrelic_license_key;
        }
    }

    gunicorn::instance {
        $gunicorn_name:
            gunicorn  => $gunicorn,
            port      => $port,
            workers   => $workers,
            appmodule => $appmodule,
            timeout   => $timeout,
            environ   => $environ,
            appdir    => "${app_dir}/zamboni";
    }
}
