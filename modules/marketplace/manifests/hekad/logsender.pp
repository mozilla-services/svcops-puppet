# send nginx logs to heka master.
class marketplace::hekad::logsender(
  $log_host = 'localhost:5565',
  $log_tcp_host = 'localhost:5566',
  $mkt_prod = true,
) {
  hekad::instance {
    'marketplace-logsender':
      config  => template('marketplace/hekad/logsender.toml'),
      hekabin => '/usr/bin/hekad';
  }
}
