# jenkins packages
class jenkins::packages(
  $version      = 'installed',
  $install_java = false,
  $javapackage  = 'java-1.7.0-oracle',
){
  # repos is needed for package installation
  realize Yumrepo['jenkins']

  # this is a hack, java package resource needs to be a virtual resource
  if $install_java {
    package {
      $javapackage:
        ensure => 'installed';
    }
  }

  package {
    'jenkins':
      ensure  => $version,
      require => [
        Yumrepo['jenkins']
      ];
  }

}
