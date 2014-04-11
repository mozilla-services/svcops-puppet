# define zamboni instance.
define marketplace::apps::zamboni(
    $worker_name,
    $app_dir,
    $port, # if this gunicorn_set is turned on, this is prefixed with 10 and 11.
    $appmodule = 'wsgi.zamboni:application',
    $workers = 12,
    $worker_class = 'sync',
    $timeout = '90',
    $environ = '',
    $newrelic_license_key = '',
    $newrelic_domain = undef,
    $nginx_settings = undef,
    $uwsgi = true,
    $user = 'mkt_prod'
) {
    $app_name = $name

    if $port < 1000 {
      $real_port =  "12${port}"
    } else {
      $real_port = $port
    }

    if $newrelic_license_key {
        $newrelic_dep = Uwsgi::Instance[$worker_name]
        marketplace::newrelic::python {
            $app_name:
                before          => $newrelic_dep,
                newrelic_domain => $newrelic_domain,
                license_key     => $newrelic_license_key;
        }
    }

    uwsgi::instance {
        $worker_name:
            app_dir   => "${app_dir}/zamboni",
            appmodule => $appmodule,
            port      => $real_port,
            home      => "${app_dir}/venv",
            user      => $user,
            workers   => $workers,
            environ   => $environ;
    }

    if $nginx_settings {
      create_resources(
        marketplace::nginx::marketplace,
        {"${app_name}" => $nginx_settings},
        {
          webpayroot              => $app_dir,
          webroot                 => $app_dir,
          marketplace_worker_name => $worker_name
        }
      )
    }
}
