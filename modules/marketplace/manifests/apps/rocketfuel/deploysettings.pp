# $name is the location of rocketfuel
define marketplace::apps::rocketfuel::deploysettings(
    $cluster,
    $domain,
    $env,
    $ssh_key
) {
    $rocketfuel_dir = $name

    file {
        "${rocketfuel_dir}/deploysettings.py":
            content => template('marketplace/apps/rocketfuel/deploysettings.py');
    }
}
