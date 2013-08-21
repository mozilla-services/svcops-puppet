# start dreadnot instance.
define dreadnot::instance(
    $settings,
    $htpasswd = '',
    $port = '9000'
) {
    include dreadnot

    $instance_name = $name
    $root = "${dreadnot::instance_root}/${instance_name}"
    file {
        $root:
            ensure => directory;
        "${root}/stacks":
            ensure => directory;
        "${root}/settings.js":
            content => $settings,
            notify  => Service["dreadnot-${instance_name}"];
        "${root}/htpasswd":
            content => $htpasswd,
            notify  => Service["dreadnot-${instance_name}"];
        "/var/dreadnot/${instance_name}":
            ensure => directory;
    }
    supervisord::service {
        "dreadnot-${instance_name}":
            command => "/opt/dreadnot/bin/dreadnot -c ${root}/settings.js -s ${root}/stacks -p ${port}",
            app_dir => "/var/dreadnot/${instance_name}",
            user    => 'root';
    }
}
