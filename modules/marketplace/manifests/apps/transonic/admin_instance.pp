# $name is the location of transonic
define marketplace::apps::transonic::admin_instance(
  $cluster,
  $domain,
  $dreadnot_instance,
  $env,
  $ssh_key,
  $project_name = 'transonic',
  $update_on_commit = false,
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

  marketplace::overlay { "${codename}::deploysettings::${name}":
    app      => $codename,
    cluster  => $cluster,
    content  => template('marketplace/apps/transonic/deploysettings.py'),
    env      => $env,
    filename => 'deploysettings.py',
  }

  dreadnot::stack {
    $domain:
      require       => File["${transonic_dir}/deploysettings.py"],
      instance_name => $dreadnot_instance,
      github_url    => 'https://github.com/mozilla/transonic',
      git_url       => 'git://github.com/mozilla/transonic.git',
      project_dir   => $transonic_dir;
  }
  if $update_on_commit {
    go_freddo::branch { "${codename}_${domain}_${env}":
      app    => $codename,
      script => "/usr/local/bin/dreadnot.deploy -e ${dreadnot_instance} ${domain}",
    }
  }
}
