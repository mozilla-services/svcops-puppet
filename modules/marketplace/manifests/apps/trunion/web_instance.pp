# vim: set expandtab ts=2 sw=2 filetype=puppet syntax=puppet:
define marketplace::apps::trunion::web_instance(
    $gunicorn_name,
    $port,
    $app_dir,
    $app_module,
    $environ,
    $gunicorn,
    $nginx_port,
    $nginx_ssl_port,
    $nginx_template = 'marketplace/nginx/trunion.conf',
    $nginx_log_buffer = true,
    $workers = 4
) {
    $app_name = $name

    gunicorn::instance {
        $gunicorn_name:
            gunicorn  => $gunicorn,
            port      => $port,
            workers   => $workers,
            appmodule => $app_module,
            appdir    => $app_dir,
            environ   => $environ;
    }

    nginx_amo::config {
        $app_name:
            content => template($nginx_template);
    }

    nginx_amo::logdir {
        $app_name:;
    }

}
