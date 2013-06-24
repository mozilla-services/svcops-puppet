class hekad(
    $log_dir = '/var/log/hekad',
    $udp_listen_address = '127.0.0.1:5565',
    $cef_address = '127.0.0.1:5565',
    $statsd_address = '127.0.0.1:8125',
    $version = '0.1.1-4'
){
    package {
        'hekad':
            ensure => $version,
            notify => Service['hekad'];
    }
    file {
        $log_dir:
            ensure => directory;

        '/etc/hekad.json':
            require => Package['hekad'],
            notify  => Service['hekad'],
            content => template('hekad/hekad.json.erb')
    }

    supervisord::service {
        'hekad':
            user    => 'root',
            command => '/usr/bin/hekad',
            app_dir => '/usr/bin',
            require => [
                File['/etc/hekad.json'],
                File[$log_dir],
            ];
    }
}
