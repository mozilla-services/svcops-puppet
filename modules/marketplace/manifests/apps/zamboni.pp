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
    $gunicorn_set = true, # runs two workers $name-a and $name-b
    $uwsgi = true,
    $user = 'nginx'
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
                user      => $user,
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
                user      => $user,
                appdir    => "${app_dir}/zamboni";
        }
    }
}
