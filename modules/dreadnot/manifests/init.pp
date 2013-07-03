#installs dreadnot
class dreadnot {
    package {
        'dreadnot':
            ensure => '0.1.3-1.66b2c8b79c';
    }
    file {
        '/etc/dreadnot.d':
            ensure  => directory,
            purge   => true,
            recurse => true;
    }
}
