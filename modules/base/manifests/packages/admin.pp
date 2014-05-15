# base packages, we install these on admin hosts
class base::packages::admin{
  package {
    [
      'git',
      'libxml2-devel',
      'libxslt-devel',
      'python-virtualenv',
    ]:
      ensure => 'latest';
  }
}
