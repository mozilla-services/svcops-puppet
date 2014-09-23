# Manage rhn related files
class base::rhn {
  $rhn_cert = hiera('rhn_ssl_cert', '')
  if $rhn_cert == '' {
    file { '/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT':
      content => template('base/RHN-ORG-TRUSTED-SSL-CERT'),
    }
  }
}
