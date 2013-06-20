# gunicorn
class gunicorn(
    $user = 'nginx'
){
    file {
        '/var/log/gunicorn':
            ensure => directory,
            owner  => $user,
            group  => $user,
            mode   => '0755';
    }

    motd {
        '0-gunicorn':
            order   => '11',
            content => "Gunicorns:\n";
    }
}
