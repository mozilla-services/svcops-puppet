# Define settings and supervisor for zambonidashboard
define marketplace::apps::zambonidashboard(
    $installdir,
    $settings, # content of settings file.
    $port,
    $user = 'apache'
) {
    $dash_name = $name
    file {
        "${installdir}/zamboni_dashboard/settings_local.py":
            content => $settings;
    }

    gunicorn::instance {
        $dash_name:
            port           => $port,
            user           => $user,
            appmodule      => 'zamboni_dashboard:app',
            appdir         => $installdir,
            nginx_upstream => false,
            gunicorn       => "${installdir}/venv/bin/gunicorn";
    }

    apache::vserverproxy {
        'dashboard.mktadm.ops.services.phx1.mozilla.com':
            proxyto => 'http://localhost:10000';
    }

    supervisord::service {
        "${dash_name}-fetch-nagios-status":
            command => "${installdir}/venv/bin/python manage.py fetch_nagios_state",
            app_dir => $installdir,
            user    => 'apache';
    }
}
