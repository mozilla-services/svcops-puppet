# ssh config class
class ssh::config(
  $allow_agent_forwarding = 'no',
  $allow_tcp_forwarding = 'no',
  $permit_root_login = 'yes',
){
  include ssh
  $sshd_config = '/etc/ssh/sshd_config'

  file{ $sshd_config:
    ensure  => 'file',
    content => template("${module_name}/sshd_config.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    notify  => Service['sshd'],
  }
}
