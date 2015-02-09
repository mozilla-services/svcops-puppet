# $name is the location of rocketfuel
define marketplace::apps::generic_js::deploysettings(
  $project_name, # e.g., marketplace-stats
  $cluster,
  $domain,
  $env,
  $ssh_key
) {
  $app_dir = $name

  marketplace::overlay { "${project_name}::deploysettings::${name}":
    app      => $project_name,
    cluster  => $cluster,
    content  => template('marketplace/apps/generic_js/deploysettings.py'),
    env      => $env,
    filename => 'deploysettings.py',
  }

  file {
    "${app_dir}/deploysettings.py":
      content => template('marketplace/apps/generic_js/deploysettings.py');
  }
}
