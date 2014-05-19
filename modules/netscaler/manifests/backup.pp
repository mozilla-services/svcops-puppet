# netscaler backup
class netscaler::backup(
  $password,
  $user = 'mktnsbackup',
){

  file {
    '/var/lib/nsbackup':
      ensure => 'directory',
      owner  => $user,
      mode   => '0700';

    "/home/${user}/.ns":
      ensure => 'directory',
      owner  => $user,
      mode   => '0700';

    "/home/${user}/.ns/pass":
      ensure  => 'file',
      content => "PASS=\'${password}\'\n",
      owner   => $user,
      mode    => '0600';
  }

  file {
    '/usr/local/bin/backup_netscaler.sh':
      owner   => $user,
      mode    => '0700',
      content => template('nswl/backup_netscaler.sh');
  }

  cron {
    'nsbackup':
      minute  => '5',
      user    => $user,
      command => '/usr/bin/flock -w 120 /var/tmp/backup_netscaler /usr/local/bin/backup_netscaler.sh > /dev/null 2>&1';
  }
}
