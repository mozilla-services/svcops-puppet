# set up for deploytools
class marketplace::deploytools {
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
