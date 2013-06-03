# defines nginx config
define nginx::config(
    $content = false,
    $source = false,
    $suffix = '.conf'
){
    if ($content != false) and ($source != false) {
        fail('You cannot specify more than one of content and source.')
    } elsif ($content == false) and ($source == false) {
        fail('Either content or source must be specified.')
    }

    if($content) {
        file {
            "/etc/nginx/managed/${name}${suffix}":
                notify  => Service['nginx'],
                content => $content;
        }
    } else {
        file {
            "/etc/nginx/managed/${name}${suffix}":
                notify => Service['nginx'],
                source => $source;
        }

    }
}
