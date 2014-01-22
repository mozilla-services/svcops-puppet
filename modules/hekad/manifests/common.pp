# base heka that some hosts share
class hekad::common(
    $udp_listen_address = '127.0.0.1:5565',
    $statsd_address = '127.0.0.1:8125',
    $carbon_output_address = '127.0.0.1:2003',
    $log_output = false,
  ) {
    hekad::instance {
        'hekad':
          config => template('hekad/hekad.toml.erb');
    }
}
