# install twemproxy and create directories.
class twemproxy(
    $servers = {},
    $version = '0.3.0-1'
){
    package  {
        'nutcracker':
            ensure => $version;
    }

    file {
        '/etc/nutcracker':
            ensure  => directory,
            purge   => true,
            recurse => true;
    }

    create_resources(twemproxy::server, $servers)
}
