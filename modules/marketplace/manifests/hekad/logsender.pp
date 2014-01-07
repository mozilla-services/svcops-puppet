# send nginx logs to heka master.
class marketplace::hekad::logsender(
    $log_host = 'localhost:5565',

) {
    hekad::instance {
        'marketplace-logsender':
            config  => template('marketplace/hekad/logsender.toml'),
            hekabin => '/usr/bin/hekad';
    }
}
