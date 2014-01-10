class twemproxy(
    $servers,
    $version = "0.3.0-1"
){
    package  {
        'nutcracker':
            ensure => $version;
    }

    create_resources(twemproxy::server, $servers)
}
