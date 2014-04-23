# $name is the location of rocketfuel
define marketplace::apps::generic_js::deploysettings(
  $cluster,
  $domain,
  $env,
  $ssh_key
) {
  $app_dir = $name

  file {
    "${app_dir}/deploysettings.py":
      content => template('marketplace/apps/generic_js/deploysettings.py');
  }
}
