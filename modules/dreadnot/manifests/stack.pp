# defines dreadnot stack
define dreadnot::stack(
    $instance_name,
    $stack = template('dreadnot/standardstack.js')
) {
    $stack_name = $name

    file {
        "${dreadnot::instance_root}/${instance_name}/stacks/${stack_name}.js":
            require => File["${dreadnot::instance_root}/${instance_name}/stacks"],
            before  => Supervisord::Service["dreadnot-${instance_name}"],
            content => $stack;
    }
}
