# install and configure tuned
class tuned (
  $profile = 'throughput-performance'
){

  $lock = '/root/.tuned'

  package {
    'tuned':
      ensure => present;
  }

  exec {
    'enable-tuned-profile':
      command   => "/usr/bin/tuned-adm profile ${profile} && touch ${lock}",
      require   => Package['tuned'],
      creates   => $lock;
  }

  service {
    'tuned':
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require   => Exec['enable-tuned-profile'];
  }

}
