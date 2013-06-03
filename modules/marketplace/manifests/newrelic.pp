# sets up base environment for newrelic
class marketplace::newrelic {
    file {
        '/etc/newrelic.d':
            ensure  => directory,
            recurse => true,
            purge   => true;
    }
}
