# describe monolith on a webserver.
define marketplace::apps::monolith::web_instance(
    $server_names, # a list of names
    $worker_name,
    $project_dir,
    $workers = 4,
    $port = '12000',
    $user = 'mkt_prod_monolith'
) {
    $config_name = $name
    nginx::config {
        $config_name:
            require => Uwsgi::Instance[$worker_name],
            content => template('marketplace/apps/monolith/web/monolith.conf');
    }

    nginx::logdir {
        $config_name:;
    }

    uwsgi::instance {
        $worker_name:
            app_dir   => "${project_dir}/monolith",
            appmodule => 'runserver:application',
            port      => $port,
            home      => "${project_dir}/venv",
            user      => $user,
            workers   => $workers;
    }
}
