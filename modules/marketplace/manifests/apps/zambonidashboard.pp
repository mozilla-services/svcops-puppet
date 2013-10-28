# Define settings and supervisor for zambonidashboard
define marketplace::apps::zambonidashboard(
    $installdir,
    $settings, # content of settings file.
    $port,
    $nginx_location = '/dashboard/' # nginx location
) {
    $dash_name = $name
    file {
        "${installdir}/zamboni_dashboard/settings_local.py":
            content => $settings;
    }

    gunicorn::instance {
        $dash_name:
            port      => $port,
            appmodule => 'zamboni_dashboard:app',
            appdir    => $installdir,
            gunicorn  => "${installdir}/venv/bin/gunicorn";
    }

    supervisord::service {
        "${dash_name}-fetch-nagios-status":
            command => "${installdir}/venv/bin/python manage.py fetch_nagios_state",
            app_dir => $installdir,
            user    => 'apache';
    }
}
