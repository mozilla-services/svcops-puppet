# $name is the location of fireplace
define marketplace::apps::fireplace::admin_instance(
  $cluster,
  $domain,
  $env,
  $project_name = 'fireplace',
  $ssh_key,
) {
  $fireplace_dir = $name

  file {
    "${fireplace_dir}/deploysettings.py":
      content => template('marketplace/apps/fireplace/deploysettings.py');
  }
}
