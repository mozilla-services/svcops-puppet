# define admin instance for trunion.
define marketplace::apps::trunion::admin_instance(
    $cluster,
    $domain,
    $env,
    $keyfile,
    $certfile,
    $chainfile,
    $syslog_name,
    $ssh_key,
    $update_ref,
    $dev = false,
    $we_are_signing = 'apps',

    $pyrepo = 'https://pyrepo.addons.mozilla.org/'
) {
    $project_dir = $name
    $ssl_dir = "${project_dir}/ssl"

    git::clone {
        "${project_dir}/trunion":
            repo => 'https://github.com/mozilla/trunion.git',

    }

    file {
        "${project_dir}/trunion/production.ini":
            require => Git::Clone["${project_dir}/trunion"],
            content => template('marketplace/apps/trunion/admin/production.ini');
    }

    file {
        "${project_dir}/trunion/deploysettings.py":
            require => Git::Clone["${project_dir}/trunion"],
            content => template('marketplace/apps/trunion/deploysettings.py');
    }
    dreadnot::stack {
        $dreadnot_name:
            instance_name => $dreadnot_instance,
            project_dir   => "${project_dir}/trunion",
            github_url    => 'https://github.com/mozilla/trunion',
            git_url       => 'git://github.com/mozilla/trunion',
    }
}
