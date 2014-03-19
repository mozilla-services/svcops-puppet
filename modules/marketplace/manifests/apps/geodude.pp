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
    $user = 'mkt_prod_geodude',
    $uwsgi = true
) {
    $app_name = $name
    $gunicorn = "${app_dir}/venv/bin/gunicorn"

    if $port < 1000 {
      $real_port =  "12${port}"
    } else {
      $real_port = $port
    }

    if $newrelic_license_key {
        if $uwsgi {
            $newrelic_dep = Uwsgi::Instance[$gunicorn_name]
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
                port      => $real_port,
                home      => "${app_dir}/venv",
                user      => $user,
                workers   => $workers,
                environ   => $environ;
        }
    } else {
        gunicorn::instance {
            $gunicorn_name:
                gunicorn  => $gunicorn,
                port      => $real_port,
                workers   => $workers,
                appmodule => $appmodule,
                timeout   => $timeout,
                environ   => $environ,
                appdir    => "${app_dir}/geodude";
        }
    }
}
