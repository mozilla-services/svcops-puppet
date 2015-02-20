# $name is the location of operator_dashboard
define marketplace::apps::marketplace_operator_dashboard::admin_instance(
  $cluster,
  $domain,
  $env,
  $ssh_key,
  $project_name = 'marketplace-operator-dashboard',
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
}
