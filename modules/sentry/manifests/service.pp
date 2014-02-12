# define sentry service
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

  file {
    "/etc/httpd/conf.d/${sentry_name}.conf":
      notify  => Service['httpd'],
      content => template('sentry/apache.conf');
  }

  supervisord::service {
    "sentry-${sentry_name}-http":
      command => "/opt/sentry/bin/sentry --config=/etc/sentry.d/${sentry_name}.py start http",
      app_dir => '/tmp',
      user    => 'apache';
    "sentry-${sentry_name}-udp":
      command => "/opt/sentry/bin/sentry --config=/etc/sentry.d/${sentry_name}.py start udp",
      app_dir => '/tmp',
      user    => 'apache';
  }
}
