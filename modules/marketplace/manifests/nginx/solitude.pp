# solitude nginx config
define marketplace::nginx::solitude(
    $server_names, # ['payments.mozilla.org']
    $project_dir,
    $worker_name
) {
    $config_name = $name

    nginx::config {
        $config_name:
            content => template('marketplace/nginx/solitude.conf');
    }

    nginx::logdir {
        $config_name:;
    }
}
