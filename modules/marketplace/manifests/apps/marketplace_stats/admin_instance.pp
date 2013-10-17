# define admin instance for marketplace stats
define marketplace::apps::marketplace_stats::admin_instance(
    $cluster,
    $domain,
    $env,
    $ssh_key,
    $dreadnot_name,
    $dreadnot_instance,
) {
    $project_dir = $name
    git::clone {
        "${project_dir}/marketplace-stats":
            repo => 'https://github.com/mozilla/marketplace-stats.git';

    }

    file {
        "${project_dir}/marketplace-stats/deploysettings.py":
            require => Git::Clone["${project_dir}/marketplace-stats"],
            content => template('marketplace/apps/default/deploysettings.py');
    }

    dreadnot::stack {
        $dreadnot_name:
            instance_name => $dreadnot_instance,
            project_dir   => "${project_dir}/marketplace-stats",
            github_url    => 'https://github.com/mozilla/marketplace-stats',
            git_url       => 'git://github.com/mozilla/marketplace-stats.git';
    }
}
