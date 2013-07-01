#define sentry service
define sentry::service(
    $db_name,
    $db_pass,
    $sentry_key,
    $sentry_port,
    $server_email,
    $email_host
) {
    $sentry_name = $name

    include sentry

    file {
        "/etc/sentry.d/${sentry_name}.py":
            content => template('sentry/sentry.conf');
    }

    nginx::config {
        "sentry_${sentry_name}":
            content => template('sentry/nginx.conf');
    }
}
