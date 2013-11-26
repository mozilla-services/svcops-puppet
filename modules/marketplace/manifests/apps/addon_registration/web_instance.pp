# describe addon_registration on a webserver.
define marketplace::apps::addon_registration::web_instance(
    $project_dir,
    $port,
    $server_names, # a list of names
    $workers = '12',
    $worker_name = 'addon-registration',
    $user = 'addon_registration_prod',
    $appmodule = 'wsgi:app'
) {
    $config_name = $name

    uwsgi::instance {
        $worker_name:
            app_dir   => "${project_dir}/addon_registration",
            appmodule => $appmodule,
            port      => $port,
            home      => "${project_dir}/venv",
            user      => $user,
            workers   => $workers,
            scl       => 'python27'
    }

    marketplace::nginx::addon_registration {
        $config_name:
            server_names => $server_names
    }

}
