# jenkins params
class jenkins::params {
  $jenkins_version = '1.509.4-1.1'
  $jenkins_home = '/var/lib/jenkins'
  $jenkins_port = '8080'
  $jenkins_handler_max = '50'
  $jenkins_handler_idle = '10'
  $javapackage = 'java-1.7.0-oracle'
  $javaversion = '1.7.0.51-1'
  $domain = 'ci.example.org'
}
