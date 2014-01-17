# install twemproxy and create directories.
class twemproxy(
    $servers = {},
    $version = '0.3.0-1'
){
    $config_dir = '/etc/nutcracker'
    package  {
        'nutcracker':
            ensure => $version;
    }

    file {
        $config_dir:
            ensure  => directory,
            purge   => true,
            recurse => true;
    }

    create_resources(twemproxy::server, $servers)
}
