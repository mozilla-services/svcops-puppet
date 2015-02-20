# $name is the location of spartacus
define marketplace::apps::spartacus::admin_instance(
  $cluster,
  $domain,
  $env,
  $ssh_key,
  $scl_name = 'python27',
  $webpay_dir = '',

  $project_name = 'spartacus',
) {
  $spartacus_dir = $name
  $codename = 'spartacus'

  git::clone { $spartacus_dir:
    repo => 'https://github.com/mozilla/spartacus.git',
  }

  file {
    "${spartacus_dir}/deploysettings.py":
      require => Git::Clone[$spartacus_dir],
      content => template('marketplace/apps/spartacus/deploysettings.py');
  }

  marketplace::overlay { "spartacus::deploysettings::${name}":
    app      => $project_name,
    cluster  => $cluster,
    content  => template('marketplace/apps/spartacus/deploysettings.py'),
    env      => $env,
    filename => 'deploysettings.py',
  }
}
