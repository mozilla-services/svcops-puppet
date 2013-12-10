# hekad
class hekad(
    $log_dir = '/var/log/hekad',
    $udp_listen_address = '127.0.0.1:5565',
    $cef_address = '127.0.0.1:5565',
    $statsd_address = '127.0.0.1:8125',
    $version = '0.4.1-1'
){
    package {
        'hekad':
            ensure => $version;
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
