# $name is the location of spartacus
define marketplace::apps::spartacus::admin_instance(
  $cluster,
  $domain,
  $dreadnot_instance,
  $env,
  $ssh_key,

  $project_name = 'spartacus',
) {
  $spartacus_dir = $name

  git::clone { $spartacus_dir:
    repo => 'https://github.com/mozilla/spartacus.git',
  }

  file {
    "${spartacus_dir}/deploysettings.py":
      require => Git::Clone[$spartacus_dir],
      content => template('marketplace/apps/spartacus/deploysettings.py');
  }

  dreadnot::stack {
    $domain:
      require       => File["${spartacus_dir}/deploysettings.py"],
      instance_name => $dreadnot_instance,
      github_url    => 'https://github.com/mozilla/spartacus',
      git_url       => 'git://github.com/mozilla/spartacus.git',
      project_dir   => $spartacus_dir;
  }
}
