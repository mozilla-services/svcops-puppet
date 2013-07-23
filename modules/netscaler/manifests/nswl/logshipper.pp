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

    cron {
        'nswllogshipper':
            minute  => '15',
            user    => 'root',
            command => '/usr/bin/flock -w 120 /var/lock/nswllogshipper /usr/local/bin/nswllogshipper';
    }
}
