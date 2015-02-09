# $name is the location of commbadge
define marketplace::apps::commbadge::deploysettings(
  $cluster,
  $domain,
  $env,
  $ssh_key
) {
  $commbadge_dir = $name

  file {
    "${commbadge_dir}/deploysettings.py":
      content => template('marketplace/apps/commbadge/deploysettings.py');
  }

  marketplace::overlay { "commbadge::deploysettings::${name}":
    app      => 'commbadge',
    cluster  => $cluster,
    content  => template('marketplace/apps/commbadge/deploysettings.py'),
    env      => $env,
    filename => 'deploysettings.py',
  }
}
