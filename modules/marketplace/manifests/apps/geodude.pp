# define geodude instance.
define marketplace::apps::geodude(
    $gunicorn_name,
    $port,
    $app_dir,
    $appmodule = 'geodude',
    $workers = 12,
    $worker_class = 'sync',
    $timeout = '90',
    $environ = '',
    $newrelic_license_key = '',
    $gunicorn_set = false, # runs two workers $name-a and $name-b
    $user = 'mkt_prod_geodude',
    $uwsgi = true
) {
    $app_name = $name
    $gunicorn = "${app_dir}/venv/bin/gunicorn"

    if $newrelic_license_key {
        if $uwsgi {
            $newrelic_dep = Uwsgi::Instance[$gunicorn_name]
        } elsif $gunicorn_set {
            $newrelic_dep = Gunicorn::Set[$gunicorn_name]
        } else {
            $newrelic_dep = Gunicorn::Instance[$gunicorn_name]
        }
        marketplace::newrelic::python {
            $app_name:
                before          => $newrelic_dep,
                newrelic_domain => $newrelic_domain,
                license_key     => $newrelic_license_key;
        }
    }
    if($uwsgi) {
        uwsgi::instance {
            $gunicorn_name:
                app_dir   => "${app_dir}/geodude",
                appmodule => $appmodule,
                port      => "12${port}",
                home      => "${app_dir}/venv",
                user      => $user,
                workers   => $workers,
                environ   => $environ;
        }
    } elsif($gunicorn_set) {
        gunicorn::set {
            $gunicorn_name:
                porta     => "10${port}",
                portb     => "11${port}",
                gunicorn  => $gunicorn,
                workers   => $workers,
                appmodule => $appmodule,
                timeout   => $timeout,
                environ   => $environ,
                appdir    => "${app_dir}/geodude";

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
                    appdir    => "${app_dir}/geodude";
            }
        }
}
