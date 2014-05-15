# base packages, we install these on admin hosts
class base::packages::admin{
  package {
    [
      'git',
    ]:
      ensure => 'latest';
  }
}
