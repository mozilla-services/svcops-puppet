# uwsgi class
class uwsgi(
    $version = '1.9.13-1'
) {
    $conf_dir = '/etc/uwsgi.d'
    $pid_dir = '/var/run/uwsgi'

    package {
        'python-uwsgi':
            ensure => $version;
        'python-uwsgitop':
            ensure => present;
    }
    group {
        'uwsgi':
            gid    => '756',
            ensure => present;
    }

    file {
        $pid_dir:
            ensure => directory,
            group  => 'uwsgi',
            mode   => 1775;

        $conf_dir:
            ensure  => directory,
            recurse => true,
            purge   => true;
    }
    nginx::config {
        'uwsgi':
            suffix  => '.params',
            content => template('uwsgi/uwsgi.nginx.conf');
    }
    motd {
        '0-uwsgi':
            order   => '12',
            content => "Uwsgi:\n";
    }
}
