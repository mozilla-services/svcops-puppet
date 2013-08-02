# solitude instance.
define marketplace::apps::solitude(
    $app_dir,
    $port,
    $workers = 12,
    $worker_name = 'payments',
    $user = 'sol_prod',
    $settings_module = 'solitude.settings',
    $appmodule = 'wsgi.playdoh:application'
) {
    $app_name = $name

    uwsgi::instance {
        $worker_name:
            app_dir   => "${app_dir}/solitude",
            appmodule => $appmodule,
            port      => $port,
            home      => "${app_dir}/venv",
            user      => $user,
            workers   => $workers,
            environ   => "DJANGO_SETTINGS_MODULE=${settings_module}";
    }

}
