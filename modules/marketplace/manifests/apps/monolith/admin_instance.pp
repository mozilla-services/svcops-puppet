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
    $pyrepo = 'https://pyrepo.addons.mozilla.org/'
) {
    $project_dir = $name

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
}
