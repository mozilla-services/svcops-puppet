# send nginx logs to heka master.
class marketplace::hekad::logsender(
  $log_tcp_host = undef,
  $mkt_prod = true,
  $send_access = false,
) {
  hekad::instance {
    'marketplace-logsender':
      config  => template('marketplace/hekad/logsender.toml'),
      hekabin => '/usr/bin/hekad';
  }
}
