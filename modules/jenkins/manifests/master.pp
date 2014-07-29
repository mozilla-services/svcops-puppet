# jenkins class
class jenkins::master(
  $domain          = 'ci.example.org',
  $jenkins_home    = '/var/lib/jenkins',
  $jenkins_version = '1.509.4-1.1',
  $include_common  = True,
  $include_nginx   = True
){
  $jenkins_port = $jenkins::config::jenkins_port
  # install jenkins packages and requirements
  class {
    'jenkins::packages':
      version => $jenkins_version;
  }

  # include common build packages
  if $include_common {
    include jenkins::packages::build
  }

  # include nginx
  if $include_nginx {
    include nginx
    $upstream = 'jenkins'
    nginx::upstream {
      $upstream:
        upstream_port => $jenkins_port,
    }
    nginx::serverproxy {
      $domain:
        proxyto => "http://${upstream}",
    }
  }

  service {
    'jenkins':
      ensure     => 'running',
      enable     => true,
      hasrestart => false,
      hasstatus  => true,
      require    => [
        Class['jenkins::packages'],
        Class['jenkins::config'],
      ];

  }
}
