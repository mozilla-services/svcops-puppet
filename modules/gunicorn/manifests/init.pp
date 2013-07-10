# gunicorn
class gunicorn {
    file {
        '/var/log/gunicorn':
            ensure => directory,
            mode   => '1777';
    }

    motd {
        '0-gunicorn':
            order   => '11',
            content => "Gunicorns:\n";
    }
}
