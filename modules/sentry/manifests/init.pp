# base sentry class
class sentry {
    package {
        'sentry':
            ensure => '5.4.5-1';
    }
    file {
        '/etc/sentry.d':
            ensure  => directory,
            recurse => true,
            purge   => true;
    }
}
