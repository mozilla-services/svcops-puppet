# ssh class
class ssh {
  package {
    'openssh-server':
      ensure => 'latest';
  }

  $ssh_package_name = $::osfamily ? {
    'Debian' => 'openssh-client',
    default  => 'openssh',
  }

  $ssh_name =  $::osfamily ? {
    'Debian' => 'ssh',
    default  => 'sshd',
  }

  package {
    'openssh':
      ensure     => 'latest',
      name       => $ssh_package_name,
  }

  service {
    'sshd':
      ensure     => 'running',
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
      name       => $ssh_name,
  }
}
