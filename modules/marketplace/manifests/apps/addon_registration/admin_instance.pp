# define admin instance for addon_registration.
define marketplace::apps::addon_registration::admin_instance(
  $cluster,
  $domain,
  $env,
  $ssh_key,
  $broker_url,
  $sql_uri,
  $dreadnot_name,
  $dreadnot_instance,
  $update_ref,
  $celery_service = 'None',
  $uwsgi ='addon-registration',
  $pyrepo = 'https://pyrepo.addons.mozilla.org/',
  $update_on_commit = false,
) {
  $project_dir = $name
  $codename = 'addon-registration'

  git::clone {
    "${project_dir}/addon_registration":
      repo => 'https://github.com/mozilla/addon-registration.git',

  }

  file {
    "${project_dir}/addon_registration/production.ini":
      require => Git::Clone["${project_dir}/addon_registration"],
      content => template('marketplace/apps/addon_registration/admin/production.ini');
  }

  file {
    "${project_dir}/addon_registration/deploysettings.py":
      require => Git::Clone["${project_dir}/addon_registration"],
      content => template('marketplace/apps/addon_registration/deploysettings.py');
  }
  dreadnot::stack {
    $dreadnot_name:
      instance_name => $dreadnot_instance,
      project_dir   => "${project_dir}/addon_registration",
      github_url    => 'https://github.com/mozilla/addon-registration',
      git_url       => 'git://github.com/mozilla/addon-registration',
  }
  if $update_on_commit {
    go_freddo::branch { "${codename}_${dreadnot_name}_${env}":
      app    => $codename,
      script => "/usr/local/bin/dreadnot.deploy -e ${dreadnot_instance} ${domain}",
    }
  }
}
