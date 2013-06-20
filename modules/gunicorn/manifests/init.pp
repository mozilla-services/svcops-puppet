# gunicorn
class gunicorn(
    $user = 'apache',
    $version = '0.14.5-1'
){
    file {
        '/var/log/gunicorn':
            ensure => directory,
            owner  => $user,
            group  => $user,
            mode   => '0755';
        '/etc/gunicorn':
            ensure  => directory,
            recurse => true,
            purge   => true;
    }

    package {
        'gunicorn':
            ensure => $version;
    }

    motd {
        '0-gunicorn':
            order => '11',
            content => "Gunicorns:\n";
    }

}
