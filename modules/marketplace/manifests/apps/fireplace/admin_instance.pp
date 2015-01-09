# $name is the location of fireplace
define marketplace::apps::fireplace::admin_instance(
  $cluster,
  $domain,
  $dreadnot_instance,
  $env,
  $ssh_key,
  $package_name = undef,
  $project_name = 'fireplace',
  $update_on_commit = false,
  $zamboni_dir = '',
) {
  $fireplace_dir = $name
  $codename = 'fireplace'

  git::clone { $fireplace_dir:
    repo => 'https://github.com/mozilla/fireplace.git',
  }

  marketplace::overlay { "fireplace::deploysettings::${name}":
    app      => 'fireplace',
    cluster  => $cluster,
    content  => template('marketplace/apps/fireplace/deploysettings.py'),
    env      => $env,
    filename => 'deploysettings.py',
  }

  file {
    "${fireplace_dir}/deploysettings.py":
      require => Git::Clone[$fireplace_dir],
      content => template('marketplace/apps/fireplace/deploysettings.py');
  }

  dreadnot::stack {
    $domain:
      require       => File["${fireplace_dir}/deploysettings.py"],
      instance_name => $dreadnot_instance,
      github_url    => 'https://github.com/mozilla/fireplace',
      git_url       => 'git://github.com/mozilla/fireplace.git',
      project_dir   => $fireplace_dir;
  }

  if $update_on_commit {
    go_freddo::branch { "${codename}_${domain}_${env}":
      app    => $codename,
      script => "/usr/local/bin/dreadnot.deploy -e ${dreadnot_instance} ${domain}",
    }
  }
}
