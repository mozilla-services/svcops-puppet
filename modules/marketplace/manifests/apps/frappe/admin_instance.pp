# $name is the location of frappe
define marketplace::apps::frappe::admin_instance(
  $cluster,
  $domain,
  $dreadnot_instance,
  $env,
  $ssh_key,
  $project_name = 'frappe',
  $pyrepo = 'https://pyrepo.addons.mozilla.org/',
  $update_on_commit = false,
  $user = 'nobody',
) {
  $frappe_dir = $name
  $codename = 'frappe'

  git::clone { $frappe_dir:
    repo => 'https://github.com/grafos-ml/frappe',
  }

  file {
    "${frappe_dir}/deploysettings.py":
      content => template('marketplace/apps/frappe/deploysettings.py');
    "${frappe_dir}/fabfile.py":
      content => template('marketplace/apps/frappe/fabfile.py');
  }->
  dreadnot::stack {
    $domain:
      require       => File["${frappe_dir}/deploysettings.py"],
      instance_name => $dreadnot_instance,
      github_url    => 'https://github.com/grafos-ml/frappe',
      git_url       => 'git://github.com/grafos-ml/frappe',
      project_dir   => $frappe_dir;
  }

  if $update_on_commit {
    go_freddo::branch { "${codename}_${domain}_${env}":
      app    => $codename,
      script => "/usr/local/bin/dreadnot.deploy -e ${dreadnot_instance} ${domain}",
    }
  }
}
