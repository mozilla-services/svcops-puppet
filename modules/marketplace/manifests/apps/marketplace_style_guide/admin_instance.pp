# $name is the location of style_guide
define marketplace::apps::marketplace_style_guide::admin_instance(
  $cluster,
  $env,
  $ssh_key,
  $project_name = 'marketplace-style-guide',
) {

  $domain = $name

  marketplace::overlay { "marketplace_style_guide::deploysettings::${name}":
    app      => $project_name,
    cluster  => $cluster,
    content  => template('marketplace/apps/marketplace_style_guide/deploysettings.py'),
    env      => $env,
    filename => 'deploysettings.py',
  }
}
