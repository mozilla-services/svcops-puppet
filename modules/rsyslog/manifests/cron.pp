# rsyslog cron
class rsyslog::cron(
    $ensure = present,
    $syslog_dir = '/data/syslogs'
){

    cron {
        'compress_and_remove_syslogs':
            ensure  => $ensure,
            command => "/usr/bin/find ${syslog_dir} -type f -amin +90 ! -path '*.bz2' ! -path '*\\.*' | /usr/bin/xargs -n 1 /usr/bin/bzip2; /bin/kill -HUP `cat /var/run/syslogd.pid`; /usr/bin/find ${syslog_dir} -type f -mtime +30 -exec rm -f {} \\;",
            minute  => '0',
            hour    => '1',
            user    => 'root';
    }
}
