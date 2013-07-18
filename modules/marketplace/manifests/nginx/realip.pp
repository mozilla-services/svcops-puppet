# from is name
define marketplace::nginx::realip(
    $from,
    $header = 'X-Forwarded-For'
) {
    $conf_name = $name

    nginx::config {
        "00-realip-${conf_name}":
            content => "set_real_ip_from ${from};\nreal_ip_header ${header};\n";
    }
}
