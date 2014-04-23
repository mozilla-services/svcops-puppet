# Defines webapp managed by chief
define marketplace::apps::chief::webapp(
  $chief_root,
  $script,
  $password
) {
  $webapp_name = $name

  file {
    "${chief_root}/webapps.d/${webapp_name}.json":
      require => Marketplace::Apps::Chief[$chief_root],
      content => template('marketplace/apps/chief.webapp.json');
  }
}
