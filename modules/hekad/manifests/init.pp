# hekad
class hekad(
    $log_dir = '/var/log/hekad',
    $udp_listen_address = '127.0.0.1:5565',
    $cef_address = '127.0.0.1:5565',
    $statsd_address = '127.0.0.1:8125',
    $carbon_output_address = '127.0.0.1:2003',
    $log_output = false,
    $version = '0.4.3-1'
){
    package {
        'hekad':
            ensure => absent;
        'heka':
            ensure  => $version,
            require => Package['hekad'];
    }

    file {
        $log_dir:
            ensure => directory;

    }

    hekad::instance {
        'hekad':
            config => template('hekad/hekad.toml.erb');
    }
}
