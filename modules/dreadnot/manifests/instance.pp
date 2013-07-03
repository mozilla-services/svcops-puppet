# start dreadnot instance.
define dreadnot::instance(
    $settings
) {
    include dreadnot

    $instance_name = $name
    file {
        "${dreadnot::instance_root}/${instance_name}":
            ensure => directory;
        "${dreadnot::instance_root}/${instance_name}/stacks":
            ensure => directory;
        "${dreadnot::instance_root}/${instance_name}/settings.js":
            content => $settings;
        "/var/dreadnot/${instance_name}":
            ensure => directory;
    }
}
