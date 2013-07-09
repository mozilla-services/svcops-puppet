# define geoip instance.
define marketplace::apps::geoip(
    $gunicorn_name,
    $port,
    $app_dir,
    $appmodule = 'wsgi.playdoh:application',
    $workers = 12,
    $worker_class = 'sync',
    $timeout = '90',
    $environ = '',
    $newrelic_license_key = '',
    $gunicorn_set = false, # runs two workers $name-a and $name-b
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
                appdir    => "${app_dir}/geoip";

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
                    appdir    => "${app_dir}/geoip";
            }
        }
}
