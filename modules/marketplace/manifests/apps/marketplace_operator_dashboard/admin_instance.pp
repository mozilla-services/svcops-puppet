# $name is the location of operator_dashboard
define marketplace::apps::marketplace_operator_dashboard::admin_instance(
  $cluster,
  $domain,
  $dreadnot_instance,
  $env,
  $ssh_key,
  $project_name = 'marketplace-operator-dashboard',
  $update_on_commit = false,
) {
  $marketplace_operator_dashboard_dir = $name
  $codename = 'marketplace-operator-dashboard'

  git::clone { $marketplace_operator_dashboard_dir:
    repo => 'https://github.com/mozilla/marketplace-operator-dashboard.git',
  }

  marketplace::overlay { "marketplace_operator_dashboard::deploysettings::${name}":
    app      => $project_name,
    cluster  => $cluster,
    content  => template('marketplace/apps/marketplace_operator_dashboard/deploysettings.py'),
    env      => $env,
    filename => 'deploysettings.py',
  }

  file {
    "${marketplace_operator_dashboard_dir}/deploysettings.py":
      require => Git::Clone[$marketplace_operator_dashboard_dir],
      content => template('marketplace/apps/marketplace_operator_dashboard/deploysettings.py');
  }

  dreadnot::stack {
    $domain:
      require       => File["${marketplace_operator_dashboard_dir}/deploysettings.py"],
      instance_name => $dreadnot_instance,
      github_url    => 'https://github.com/mozilla/marketplace-operator-dashboard',
      git_url       => 'git://github.com/mozilla/marketplace-operator-dashboard.git',
      project_dir   => $marketplace_operator_dashboard_dir;
  }
  if $update_on_commit {
    go_freddo::branch { "${codename}_${domain}_${env}":
      app    => $codename,
      script => "/usr/local/bin/dreadnot.deploy -e ${dreadnot_instance} ${domain}",
    }
  }
}
