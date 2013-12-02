# vim: set expandtab ts=2 sw=2 filetype=puppet syntax=puppet:
define marketplace::apps::trunion::web_instance(
    $gunicorn_name,
    $app_dir,
    $app_module = 'trunion.run:application',
    $port = '10000',
    $nginx_port = '80',
    $nginx_ssl_port = '81',
    $nginx_template = 'marketplace/nginx/trunion.conf',
    $nginx_log_buffer = true,
    $workers = 4
) {
    include marketplace::apps::trunion::packages

    $app_name = $name
    $gunicorn = "${app_dir}/venv/bin/python ${app_dir}/venv/bin/gunicorn"
    $environ = "TRUNION_INI=${app_dir}/trunion/production.ini, LD_LIBRARY_PATH=/opt/nfast/toolkits/hwcrhk"

    gunicorn::instance {
        $gunicorn_name:
            gunicorn  => $gunicorn,
            port      => $port,
            workers   => $workers,
            appmodule => $app_module,
            appdir    => $app_dir,
            environ   => $environ;
    }

    nginx::config {
        $app_name:
            content => template($nginx_template);
    }

    nginx::logdir {
        $app_name:;
    }

}
