# solitude instance.
define marketplace::apps::solitude(
    $app_dir,
    $port,
    $workers = 12,
    $worker_name = 'payments',
    $user = 'sol_prod',
    $settings_module = 'solitude.settings',
    $appmodule = 'wsgi.playdoh:application',
    $is_proxy = false,
    $newrelic_license_key = ''
) {
    $app_name = $name

    if $is_proxy {
        $environ = ',SOLITUDE_PROXY=\'enabled\''
    } else {
        $environ = ''
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
            app_dir   => "${app_dir}/solitude",
            appmodule => $appmodule,
            port      => $port,
            home      => "${app_dir}/venv",
            user      => $user,
            workers   => $workers,
            environ   => "DJANGO_SETTINGS_MODULE=${settings_module}${environ}";
    }

}
