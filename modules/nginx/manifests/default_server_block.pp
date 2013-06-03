# adds a config to the default vserver.
define nginx::default_server_block(
    $content
) {
    $conf_name = $name
    nginx::config {
        "${conf_name}_default":
            content => $content,
            suffix  => '.default';
    }
}
