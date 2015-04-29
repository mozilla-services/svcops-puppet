# $name is the location of fireplace
define marketplace::apps::fireplace::admin_instance(
  $cluster,
  $domain,
  $env,
  $ssh_key,
  $package_name = undef,
  $project_name = 'fireplace',
  $zamboni_dir = '',
) {
  $fireplace_dir = $name
  $codename = 'fireplace'

  git::clone { $fireplace_dir:
    repo => 'https://github.com/mozilla/fireplace.git',
  }

  marketplace::overlay { "fireplace::deploysettings::${name}":
    app      => $project_name,
    cluster  => $cluster,
    content  => template('marketplace/apps/fireplace/deploysettings.py'),
    env      => $env,
    filename => 'deploysettings.py',
  }
}
