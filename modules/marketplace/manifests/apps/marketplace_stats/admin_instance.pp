# define admin instance for marketplace stats
define marketplace::apps::marketplace_stats::admin_instance(
    $cluster,
    $domain,
    $env,
    $ssh_key,
    $dreadnot_name,
    $dreadnot_instance,
    $update_on_commit = false,
) {
    $project_dir = $name
    $codename = 'marketplace-stats'
    git::clone {
        "${project_dir}/marketplace-stats":
            repo => 'https://github.com/mozilla/marketplace-stats.git';

    }

    marketplace::apps::generic_js::deploysettings {
        "${project_dir}/marketplace-stats":
            cluster      => $cluster,
            domain       => $domain,
            env          => $env,
            project_name => $codename,
            ssh_key      => $ssh_key,
            require      => Git::Clone["${project_dir}/marketplace-stats"],
    }

    dreadnot::stack {
        $dreadnot_name:
            instance_name => $dreadnot_instance,
            project_dir   => "${project_dir}/marketplace-stats",
            github_url    => 'https://github.com/mozilla/marketplace-stats',
            git_url       => 'git://github.com/mozilla/marketplace-stats.git';
    }
  if $update_on_commit {
    go_freddo::branch { "${codename}_${domain}_${env}":
      app    => $codename,
      script => "/usr/local/bin/dreadnot.deploy -e ${dreadnot_instance} ${domain}",
    }
  }
}
