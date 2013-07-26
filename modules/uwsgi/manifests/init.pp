# uwsgi class
class uwsgi(
    $version = '1.9.13-1'
) {
    include uwsgi::groups

    $conf_dir = '/etc/uwsgi.d'
    $pid_dir = '/var/run/uwsgi'
    $log_dir = '/var/log/uwsgi'

    package {
        'python-uwsgi':
            ensure => $version;
        'python-uwsgitop':
            ensure => present;
    }

    file {
        $pid_dir:
            ensure => directory,
            group  => 'uwsgi',
            mode   => '0775';

        $log_dir:
            ensure => directory,
            group  => 'uwsgi',
            mode   => '0775';

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
