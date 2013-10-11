# defines dreadnot stack
define dreadnot::stack(
    $instance_name,
    $project_dir = '',
    $git_url = '',
    $github_url = '',
    $region = 'phx1',
    $commander_script = undef,
    $stack = template('dreadnot/standardstack.js')
) {
    $stack_name = $name

    file {
        "${dreadnot::instance_root}/${instance_name}/stacks/${stack_name}.js":
            require => File["${dreadnot::instance_root}/${instance_name}/stacks"],
            before  => Supervisord::Service["dreadnot-${instance_name}"],
            notify  => Service["dreadnot-${instance_name}"],
            content => $stack;
    }

    concat::fragment {
        "settings_${stack_name}_${instance_name}.js":
            target  => "${dreadnot::instance_root}/${instance_name}/settings.js",
            content => template('dreadnot/settings_stack.js'),
            order   => 05;
    }
}
