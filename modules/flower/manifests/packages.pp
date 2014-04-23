# packages for flower

class flower::packages {
  package {
    'flower':
      ensure => present;
  }
  package {
    'python-redis':
      ensure => present;
  }
  package {
    'python-celery':
      ensure => present;
  }
  package {
    'python-tornado':
      ensure => present;
  }
  package {
    'python-anyjson':
      ensure => present;
  }
  package {
    'python-amqp':
      ensure => present;
  }
  package {
    'python-ordereddict':
      ensure => present;
  }
  package {
    'python-billiard':
      ensure => present;
  }
  package {
    'python-kombu':
      ensure => present;
  }
}
