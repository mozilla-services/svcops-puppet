# $name is the location of transonic
define marketplace::apps::transonic::admin_instance(
  $cluster,
  $domain,
  $env,
  $ssh_key,
  $project_name = 'transonic',
) {
  $transonic_dir = $name
  $codename = 'transonic'

  git::clone { $transonic_dir:
    repo => 'https://github.com/mozilla/transonic.git',
  }

  file {
    "${transonic_dir}/deploysettings.py":
      require => Git::Clone[$transonic_dir],
      content => template('marketplace/apps/transonic/deploysettings.py');
  }

  marketplace::overlay { "${project_name}::deploysettings::${name}":
    app      => $project_name,
    cluster  => $cluster,
    content  => template('marketplace/apps/transonic/deploysettings.py'),
    env      => $env,
    filename => 'deploysettings.py',
  }
}
