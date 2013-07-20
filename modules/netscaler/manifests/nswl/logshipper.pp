class netscaler::nswl::logshipper(
   $log_host = 'loghost',
   $log_host_user = 'logpull',
   $log_host_key = '/root/keys/logpull'
) {
    file {
        '/usr/local/bin/nswllogshipper':
            owner   => 'root',
            mode    => '0700',
            content => template('netscaler/nswl.logshipper.sh');
    }
}
