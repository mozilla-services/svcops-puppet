# $name is the location of fireplace
define marketplace::apps::fireplace::deploysettings(
    $cluster,
    $domain,
    $env,
    $ssh_key
) {
    $zamboni_dir = $name

    file {
        "${zamboni_dir}/deploysettings.py":
            content => template('marketplace/apps/zamboni/deploysettings.py');
    }
}
