# duosecurity base module
class ssh::duo(
  $ssh_duo_integration_key=undef,
  $ssh_duo_security_key=undef,
  $ssh_duo_api_host=undef,
){

  package {
    [
      'duo_unix',
      'libduo'
    ]:
      ensure => 'installed';
  }->

  file {
    '/etc/duo':
      ensure  => 'directory',
      group   => 'root',
      mode    => '0701',
      owner   => 'root';

    '/etc/duo/login_duo.conf':
      ensure  => 'file',
      content => template('ssh/login_duo_conf.erb'),
      group   => 'root',
      mode    => '0600',
      owner   => 'sshd';
  }
}
