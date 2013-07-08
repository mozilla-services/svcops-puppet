# class ntpd
class ntpd (
  $ntp_servers = undef,
){

    $ntp_name = $::osfamily ? {
        'Debian' => 'ntp',
        default  => 'ntpd',
    }
    package {
        'ntp':
            ensure => present
    }

    file {
        '/etc/ntp.conf':
          ensure  => present,
          content => template('ntpd/ntp.conf.erb'),
          notify  => Service['ntpd'],
    }

    service {
        'ntpd':
            ensure       => running,
            name         => $ntp_name,
            require      => Package['ntp'],
    }

}
