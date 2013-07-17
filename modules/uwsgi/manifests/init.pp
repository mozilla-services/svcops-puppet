# uwsgi class
class uwsgi(
    $version = '1.9.13-1'
) {
    $conf_dir = '/etc/uwsgi.d'

    package {
        'python-uwsgi':
            ensure => $version;
        'python-uwsgitop':
            ensure => present;
    }
    file {
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
