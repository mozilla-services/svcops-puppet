# define admin instance for monolith.
define marketplace::apps::monolith::admin_instance(
  $es_url,
  $statsd_host,
  $cluster,
  $domain,
  $env,
  $ssh_key,
  $pyrepo = 'https://pyrepo.addons.mozilla.org/',
) {
  $project_dir = $name
  $codename = 'monolith'

  git::clone {
    "${project_dir}/monolith":
      repo => 'https://github.com/mozilla/monolith.git';
  }

  file {
    "${project_dir}/monolith/monolith.ini":
      require => Git::Clone["${project_dir}/monolith"],
      content => template('marketplace/apps/monolith/admin/web.ini');
  }

  file {
    "${project_dir}/monolith/deploysettings.py":
      require => Git::Clone["${project_dir}/monolith"],
      content => template('marketplace/apps/monolith/deploysettings.py');
  }
}
