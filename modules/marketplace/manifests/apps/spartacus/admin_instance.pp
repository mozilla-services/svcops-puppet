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

  marketplace::overlay { "spartacus::deploysettings::${name}":
    app      => $project_name,
    cluster  => $cluster,
    content  => template('marketplace/apps/spartacus/deploysettings.py'),
    env      => $env,
    filename => 'deploysettings.py',
  }
}
