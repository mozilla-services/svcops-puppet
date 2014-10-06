# manage cacert
class base::cacert {

  package {
    'ca-certificates':
      ensure => 'latest',
  }

  file {
    '/etc/pki/tls/certs/ca-bundle.crt':
      ensure  => 'file',
      content => template('base/etc/cacert/ca-bundle.crt'),
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
  }

  file {
    '/etc/pki/tls/certs/mozilla-root.crt':
      ensure  => 'file',
      content => template('base/etc/cacert/mozilla-root.crt'),
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
  }
}
