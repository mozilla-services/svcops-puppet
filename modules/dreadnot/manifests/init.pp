#installs dreadnot
class dreadnot(
    $version = '0.1.3-1.66b2c8b79c',
    $root = '/opt/dreadnot'
){
    include dreadnot::plugins
    $instance_root = "${root}/instances"
    package {
        'dreadnot':
            ensure => $version;
    }
    file {
        $instance_root:
            ensure  => directory,
            require => Package['dreadnot'],
            purge   => true,
            recurse => true;
        '/var/dreadnot':
            ensure => directory;
    }
}
