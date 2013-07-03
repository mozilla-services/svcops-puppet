# start dreadnot instance.
define dreadnot::instance(
    $settings
) {
    include dreadnot

    $instance_name = $name
    file {
        "/etc/dreadnot.d/${instance_name}":
            ensure => directory;
        "/etc/dreadnot.d/${instance_name}/stacks":
            ensure => directory;
        "/etc/dreadnot.d/${instance_name}/settings.js":
            content => $settings;
    }
}
