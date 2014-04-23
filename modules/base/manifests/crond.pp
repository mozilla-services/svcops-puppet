# enable crond everywere
class base::crond {

  $cron_service = $::osfamily ? {
    'Debian' => 'cron',
    'RedHat' => 'crond',
  }

  service {
    $cron_service:
      ensure => running,
      enable => true;
  }
}
