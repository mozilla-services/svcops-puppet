#installs dreadnot
class dreadnot(
    $version = '0.1.3-1.66b2c8b79c',
    $instance_root = '/opt/dreadnot/instances'
){
    package {
        'dreadnot':
            ensure => $version;
    }
    file {
        $instance_root:
            ensure   => directory,
            requires => Package['dreadnot'],
            purge    => true,
            recurse  => true;
        '/var/dreadnot':
            ensure => directory;
    }
}
