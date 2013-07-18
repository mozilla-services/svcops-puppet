# gunicorn
class gunicorn {
    $conf_dir = '/etc/gunicorn.d'
    $log_dir = '/var/log/gunicorn'
    $pid_dir = '/var/run/gunicorn'
    file {
        $pid_dir:
            ensure => directory,
            mode   => '1777';
        $log_dir:
            ensure => directory,
            mode   => '1777';
        $conf_dir:
            ensure  => directory,
            purge   => true,
            recurse => true;
    }

    motd {
        '0-gunicorn':
            order   => '11',
            content => "Gunicorns:\n";
    }
}
