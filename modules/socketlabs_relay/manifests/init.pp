# create a socketlabs relay host.
class socketlabs_relay(
  $mynetworks = '127.0.0.0/8',
  $relayhost = 'smtp.socketlabs.com',
  $relayuser = '',
  $relaypass = ''
) {
  file {
    '/etc/postfix':
      ensure  => 'directory',
      require => Package['postfix'];

    '/etc/postfix/main.cf':
      notify  => Service['postfix'],
      content => template('socketlabs_relay/main.cf.erb');

    '/etc/postfix/relay_auth':
      mode    => '0600',
      notify  => Exec['relay_auth'],
      content => template('socketlabs_relay/relay_auth.erb');
  }

  exec {
    'relay_auth':
      command     => '/usr/sbin/postmap hash:/etc/postfix/relay_auth',
      refreshonly => true,
      require     => Package['postfix'];
  }

  service {
    'postfix':
      ensure  => 'running',
      require => Package['postfix'];
  }

  package {
    'postfix':
      ensure => 'present';
  }
}
