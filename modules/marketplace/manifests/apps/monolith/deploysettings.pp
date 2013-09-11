# $name is the location of fireplace
define marketplace::apps::monolith::deploysettings(
    $cluster,
    $domain,
    $env,
    $ssh_key
) {
    $monolith_dir = $name

    file {
        "${monolith_dir}/deploysettings.py":
            content => template('marketplace/apps/monolith/deploysettings.py');
    }
}
