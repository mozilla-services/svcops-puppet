# $name is the location of discoplace
define marketplace::apps::discoplace::admin_instance(
  $cluster,
  $domain,
  $env,
  $ssh_key,
  $project_name = 'discoplace',
) {
  $discoplace_dir = $name
  $codename = 'discoplace'

  git::clone { $discoplace_dir:
    repo => 'https://github.com/mozilla/discoplace.git',
  }

  file {
    "${discoplace_dir}/deploysettings.py":
      require => Git::Clone[$discoplace_dir],
      content => template('marketplace/apps/discoplace/deploysettings.py');
  }
}
