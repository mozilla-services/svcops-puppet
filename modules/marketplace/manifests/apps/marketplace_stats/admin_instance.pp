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

    marketplace::apps::generic_js::deploysettings {
        "${project_dir}/marketplace-stats":
            cluster => $cluster,
            domain  => $domain,
            env     => $env,
            ssh_key => $ssh_key,
            require => Git::Clone["${project_dir}/marketplace-stats"],
    }

    dreadnot::stack {
        $dreadnot_name:
            instance_name => $dreadnot_instance,
            project_dir   => "${project_dir}/marketplace-stats",
            github_url    => 'https://github.com/mozilla/marketplace-stats',
            git_url       => 'git://github.com/mozilla/marketplace-stats.git';
    }
}
