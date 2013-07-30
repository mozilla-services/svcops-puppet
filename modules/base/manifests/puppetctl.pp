# manage puppetctl on hosts
class base::puppetctl{
    file {
        '/usr/sbin/puppetctl':
            ensure  => present,
            user    => 'root',
            mode    => '0700',
            content => template('base/sbin/puppetctl');
    }
}
