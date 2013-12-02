# define admin instance for trunion.
define marketplace::apps::trunion::admin_instance(
    $cluster,
    $domain,
    $appname,
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
    $installed_dir = regsubst($project_dir, 'src', 'www')
    $ssl_dir = "${installed_dir}/ssl"

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
}
