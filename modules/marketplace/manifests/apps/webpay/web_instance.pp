# define zamboni instance.
define marketplace::apps::webpay::web_instance(
    $worker_name,
    $port,
    $app_dir,
    $appmodule = 'wsgi.playdoh:application',
    $workers = 12,
    $timeout = '90',
    $environ = '',
    $newrelic_license_key = '',
    $user = 'mkt_prod_webpay',
    $scl = undef
) {
    $app_name = $name
    $gunicorn = "${app_dir}/venv/bin/gunicorn"

    if $port < 1000 {
      $real_port =  "12${port}"
    } else {
      $real_port = $port
    }

    if $newrelic_license_key {
        marketplace::newrelic::python {
            $app_name:
                before      => Uwsgi::Instance[$worker_name],
                license_key => $newrelic_license_key;
        }
    }

    uwsgi::instance {
        $worker_name:
            app_dir   => "${app_dir}/webpay",
            appmodule => $appmodule,
            port      => $real_port,
            home      => "${app_dir}/venv",
            user      => $user,
            workers   => $workers,
            scl       => $scl,
            environ   => $environ;
    }
}
