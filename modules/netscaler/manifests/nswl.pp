# config for netscaler weblogger.
class netscaler::nswl(
    $version = 'dara_124_10-10.1',
    $logdir = '/data/netscaler/logs',
    $user = 'nswl',
    $nsips = [], # list of hashes {ip => '10...', password => 'encrypted_auth_string'}
    $filters = [] # list of hashes {name, filter, logFormat}
){
    package {
        'NSweblog':
            ensure => $version;
    }

    if $user == 'nswl' {
    user {
        $user:
            ensure => present,
            shell  => '/sbin/nologin';
    }
    }

    file {
        $logdir:
            owner   => $user,
            recurse => true,
            ensure  => directory;

        '/etc/nswl.conf':
            require => Package['NSweblog'],
            content => template('netscaler/nswl.conf');
    }

    supervisord::service {
        'nswl':
            require => [File[$logdir], File['/etc/nswl.conf']],
            command => "/usr/local/netscaler/bin/nswl -start -f /etc/nswl.conf",
            app_dir => $logdir,
            user    => $user;
    }
}
