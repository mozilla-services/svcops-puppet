# $name is the location of fireplace
define marketplace::apps::fireplace::deploysettings(
    $cluster,
    $domain,
    $env,
    $ssh_key
) {
    $fireplace_dir = $name

    file {
        "${fireplace_dir}/deploysettings.py":
            content => template('marketplace/apps/fireplace/deploysettings.py');
    }
}
