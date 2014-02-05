# Define settings and supervisor for zambonidashboard
define marketplace::apps::zambonidashboard(
    $installdir,
    $domain, # dashboard.example.com
    $settings, # content of settings file.
    $port,
    $webserver = 'httpd', ## nginx, httpd, false
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
            gunicorn       => "${installdir}/venv/bin/gunicorn";
    }

    # add nginx configs to host
    if $webserver == 'nginx' {
        $upstream = $dash_name
        nginx::upstream {
            $upstream:
                upstream_port => $port,
                require       => Gunicorn::Instance[$name];
        }
        nginx::serverproxy {
            $domain:
                proxyto => "http://${upstream}";
        }
    }
    if $webserver == 'httpd' {
        apache::vserverproxy {
            $domain:
                proxyto => "http://localhost:${port}",
                require => Gunicorn::Instance[$name];

        }
    }
    supervisord::service {
        "${dash_name}-fetch-nagios-status":
            command => "${installdir}/venv/bin/python manage.py fetch_nagios_state",
            app_dir => $installdir,
            user    => 'apache';
    }
}
