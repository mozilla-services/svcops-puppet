# set up for deploytools
class fabdeploytools::deploytools {
    package {
        'prelink':
            ensure => absent;
    }
    file {
        '/etc/deploytools':
            ensure  => directory,
            recurse => true,
            purge   => true;
        '/etc/deploytools/envs':
            ensure  => directory,
            recurse => true,
            purge   => true;
    }
}
