# jenkins class
class jenkins::master(
  $domain          = $jenkins::params::domain,
  $jenkins_home    = $jenkins::params::jenkins_home,
  $jenkins_port    = $jenkins::params::jenkins_port,
  $jenkins_version = $jenkins::params::jenkins_version,
  $include_common  = True,
  $include_nginx   = True
) inherits jenkins::params {

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
