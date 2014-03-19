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
    $newrelic_domain = undef,
    $uwsgi = true,
    $user = 'mkt_prod'
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
                app_dir   => "${app_dir}/zamboni",
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
                port      => $port,
                workers   => $workers,
                appmodule => $appmodule,
                timeout   => $timeout,
                environ   => $environ,
                user      => $user,
                appdir    => "${app_dir}/zamboni";
        }
    }
}
