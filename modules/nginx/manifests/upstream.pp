# adds an upstream proxy.
define nginx::upstream(
    $upstream_port,
    $upstream_host = '127.0.0.1'
) {
    $upstream_name = $name
    nginx::config {
        "upstream_${upstream_name}":
            content => "upstream ${upstream_name} { server ${upstream_host}:${upstream_port}; }\n";
    }
}
