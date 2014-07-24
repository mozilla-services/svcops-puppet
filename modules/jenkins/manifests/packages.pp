# jenkins packages
class jenkins::packages(
  $version      = 'present',
  $install_java = false,
  $javapackage  = $jenkins::params::javapackage
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
