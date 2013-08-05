# adds an upstream proxy to a unix socket
define nginx::upstream_unix(
    $upstream_file
) {
    $upstream_name = $name
    nginx::config {
        "upstream_${upstream_name}":
            content => "upstream ${upstream_name} { server unix:${upstream_file}; }\n";
    }
}
