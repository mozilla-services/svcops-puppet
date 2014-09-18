# $name is the location of frappe
define marketplace::apps::frappe::admin_instance(
  $cluster,
  $dreadnot_instance,
  $env,
  $project_dir,
  $settings,
  $ssh_key,
  $data_path = undef,
  $pyrepo = 'https://pyrepo.addons.mozilla.org/',
  $scl_name = undef,
  $update_on_commit = false,
  $user = 'nobody',

) {
  $domain = $name

  $codename = 'frappe'
  $project_name = $codename

  git::clone { $project_dir:
    repo => 'https://github.com/grafos-ml/frappe',
  }

  create_resources(
    'marketplace::apps::frappe::settings',
    { "${domain}" => $settings},
    {
      'project_dir' => $project_dir,
      'domain'      => $domain,
      'require'     => Git::Clone[$project_dir],
    }
  )

  file {
    "${project_dir}/deploysettings.py":
      content => template('marketplace/apps/frappe/admin/deploysettings.py');
    "${project_dir}/fabfile.py":
      content => template('marketplace/apps/frappe/admin/fabfile.py');
  }->
  dreadnot::stack {
    $domain:
      require       => File["${project_dir}/deploysettings.py"],
      instance_name => $dreadnot_instance,
      github_url    => 'https://github.com/grafos-ml/frappe',
      git_url       => 'git://github.com/grafos-ml/frappe',
      project_dir   => $project_dir;
  }

  if $update_on_commit {
    go_freddo::branch { "${codename}_${domain}_${env}":
      app    => $codename,
      script => "/usr/local/bin/dreadnot.deploy -e ${dreadnot_instance} ${domain}",
    }
  }
}
