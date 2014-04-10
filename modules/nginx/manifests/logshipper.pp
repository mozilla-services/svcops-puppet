# ship them logs
class nginx::logshipper(
    $log_host = 'loghost',
    $log_host_user = 'logpull',
    $log_host_key = '/root/.ssh/logpull',
    $log_host_key_content,
) {
    file {
        '/usr/local/bin/nginxlogshipper':
            owner   => 'root',
            mode    => '0700',
            content => template('nginx/nginx.logshipper.sh');
    }

    file {
      $log_host_key:
            owner   => 'root',
            mode    => '0700',
            content => $log_host_key_content;
    }

    cron {
        'nginxlogshipper':
            minute  => '15',
            hour    => '1',
            user    => 'root',
            command => '/usr/bin/flock -w 120 /var/lock/nginxlogshipper /usr/local/bin/nginxlogshipper';
    }
}
