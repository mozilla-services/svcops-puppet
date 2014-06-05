# $name is the location of transonic
define marketplace::apps::transonic::admin_instance(
  $cluster,
  $domain,
  $dreadnot_instance,
  $env,
  $ssh_key,
  $project_name = 'transonic',
) {
  $transonic_dir = $name

  git::clone { $transonic_dir:
    repo => 'https://github.com/mozilla/transonic.git',
  }

  file {
    "${transonic_dir}/deploysettings.py":
      require => Git::Clone[$transonic_dir],
      content => template('marketplace/apps/transonic/deploysettings.py');
  }

  dreadnot::stack {
    $domain:
      require       => File["${transonic_dir}/deploysettings.py"],
      instance_name => $dreadnot_instance,
      github_url    => 'https://github.com/mozilla/transonic',
      git_url       => 'git://github.com/mozilla/transonic.git',
      project_dir   => $transonic_dir;
  }
}
