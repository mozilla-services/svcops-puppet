# $name is the location of discoplace
define marketplace::apps::discoplace::admin_instance(
  $cluster,
  $domain,
  $dreadnot_instance,
  $env,
  $ssh_key,
  $project_name = 'discoplace',
) {
  $discoplace_dir = $name

  git::clone { $discoplace_dir:
    repo => 'https://github.com/mozilla/discoplace.git',
  }

  file {
    "${discoplace_dir}/deploysettings.py":
      require => Git::Clone[$discoplace_dir],
      content => template('marketplace/apps/discoplace/deploysettings.py');
  }

  dreadnot::stack {
    $domain:
      require       => File["${discoplace_dir}/deploysettings.py"],
      instance_name => $dreadnot_instance,
      github_url    => 'https://github.com/mozilla/discoplace',
      git_url       => 'git://github.com/mozilla/discoplace.git',
      project_dir   => $discoplace_dir;
  }
}
