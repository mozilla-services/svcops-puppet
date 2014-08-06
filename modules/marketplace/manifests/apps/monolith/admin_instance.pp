# define admin instance for monolith.
define marketplace::apps::monolith::admin_instance(
    $es_url,
    $statsd_host,
    $cluster,
    $domain,
    $env,
    $ssh_key,
    $dreadnot_name,
    $dreadnot_instance,
    $pyrepo = 'https://pyrepo.addons.mozilla.org/',
    $update_on_commit = false,
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
    dreadnot::stack {
        $dreadnot_name:
            instance_name => $dreadnot_instance,
            project_dir   => "${project_dir}/monolith",
            github_url    => 'https://github.com/mozilla/monolith',
            git_url       => 'git://github.com/mozilla/monolith.git';
    }

  if $update_on_commit {
    go_freddo::branch { "${codename}_${domain}_${env}":
      app    => $codename,
      script => "/usr/local/bin/dreadnot.deploy -e ${env} ${domain}",
    }
  }
}
