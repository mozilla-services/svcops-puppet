# $name is the location of frappe
define marketplace::apps::frappe::admin_instance(
  $cluster,
  $env,
  $domain,
  $settings,
  $ssh_key,
  $data_path = undef,
  $pyrepo = 'https://pyrepo.addons.mozilla.org/',
  $scl_name = undef,
  $user = 'nobody',
  $uwsgi = 'frappe',
) {
  $project_dir = $name

  $codename = 'frappe'
  $project_name = $codename

  create_resources(
    'marketplace::apps::frappe::settings',
    { "${domain}" => $settings},
    {
      'cluster'     => $cluster,
      'codename'    => $codename,
      'domain'      => $domain,
      'env'         => $env,
      'project_dir' => $project_dir,
    }
  )
  cron {
    "frappe-daily-${env}":
      command => "cd ${project_dir} && /usr/bin/fab cron",
      user    => 'root',
      hour    => '6',
      minute  => '5',
  }

  Marketplace::Overlay {
    app     => $codename,
    cluster => $cluster,
    env     => $env,
  }

  marketplace::overlay {
    "frappe::deploysettings::${name}":
      content  => template('marketplace/apps/frappe/admin/deploysettings.py'),
      filename => 'deploysettings.py';

    "frappe::fabfile::${name}":
      content  => template('marketplace/apps/frappe/admin/fabfile.py'),
      filename => 'fabfile.py';

    "frappe::requirements::${name}":
      content  => template('marketplace/apps/frappe/admin/requirements.prod.txt'),
      filename => 'requirements.prod.txt';
  }
}
