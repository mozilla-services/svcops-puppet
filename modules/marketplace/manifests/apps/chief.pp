# Defines chief instance. Declare webapps with marketplace::apps::chief::webapp
define marketplace::apps::chief(
  $redis_host,
  $redis_port,
  $notifier_endpoint,
  $notifier_key,
  $log_root,
  $user = 'root'
) {
  $installdir = $name
  file {
    "${installdir}/webapps.d":
      ensure  => directory,
      purge   => true,
      recurse => true;

    "${installdir}/settings.py":
      content => template('marketplace/apps/chief.settings.py');

    "${installdir}/logs":
      ensure => directory;
  }
}
