# base heka that some hosts share
class hekad::common(
  $carbon_output_address = '127.0.0.1:2003',
  $elasticsearch_url = undef,
  $http_status_loggers = [],
  $log_output = false,
  $sandbox_hmac_key = '',
  $statsd_address = '127.0.0.1:8125',
  $udp_listen_address = '127.0.0.1:5565',
) {
  hekad::instance {
    'hekad':
      config => template('hekad/hekad.toml.erb');
  }
}
