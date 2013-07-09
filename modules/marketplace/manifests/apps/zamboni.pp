# define zamboni instance.
define marketplace::apps::zamboni(
    $gunicorn_name,
    $app_dir,
    $port, # if this gunicorn_set is turned on, this is prefixed with 10 and 11.
    $appmodule = 'wsgi.zamboni:application',
    $workers = 12,
    $worker_class = 'sync',
    $timeout = '90',
    $environ = '',
    $newrelic_license_key = '',
    $gunicorn_set = true, # runs two workers $name-a and $name-b
) {
    $app_name = $name
    $gunicorn = "${app_dir}/venv/bin/gunicorn"

    if $newrelic_license_key {
        $newrelic_dep = $gunicorn_set ? {
            true    => Gunicorn::Set[$gunicorn_name],
            default => Gunicorn::Instance[$gunicorn_name],
        }
        marketplace::newrelic::python {
            $app_name:
                before      => $newrelic_dep,
                license_key => $newrelic_license_key;
        }
    }

    if($gunicorn_set) {
    gunicorn::set {
        $gunicorn_name:
            porta     => "10${port}",
            portb     => "11${port}",
            gunicorn  => $gunicorn,
            workers   => $workers,
            appmodule => $appmodule,
            timeout   => $timeout,
            environ   => $environ,
            appdir    => "${app_dir}/zamboni";

    }
    } else {
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
}
