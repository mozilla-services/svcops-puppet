# $name is the location of commonplace app
define marketplace::apps::commonplace::deploysettings(
  $project_name, # e.g., marketplace-stats
  $cluster,
  $domain,
  $env,
  $ssh_key,
  $zamboni_dir = undef,
) {
  $app_dir = $name

  marketplace::overlay { "${project_name}::deploysettings::${name}":
    app      => $project_name,
    cluster  => $cluster,
    content  => template('marketplace/apps/commonplace/deploysettings.py'),
    env      => $env,
    filename => 'deploysettings.py',
  }
}
