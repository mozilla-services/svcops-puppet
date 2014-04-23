class nfsclient::mnt_netapp {
  file {
    '/mnt/netapp':
      ensure => directory,
      owner => root,
      group => root;
  }
}
