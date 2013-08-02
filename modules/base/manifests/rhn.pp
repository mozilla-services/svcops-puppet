# Manage rhn related files
class base::rhn {
  file {
    '/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT':
      ensure  => present,
      content => file_('base/RHN-ORG-TRUSTED-SSL-CERT')
  }
}
