# $name is the location of yogafire
define marketplace::apps::yogafire::admin_instance(
  $cluster,
  $domain,
  $env,
  $ssh_key,
  $zamboni_dir,
  $project_name = 'yogafire',
) {
  $yogafire_dir = $name
  $codename = 'yogafire'

  marketplace::overlay { "${codename}::deploysettings::${name}":
    app      => $codename,
    cluster  => $cluster,
    content  => template('marketplace/apps/yogafire/deploysettings.py'),
    env      => $env,
    filename => 'deploysettings.py',
  }
}
