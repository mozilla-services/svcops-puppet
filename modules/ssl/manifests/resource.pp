# define ssl resource
define ssl::resource(
    $content,
    $ssl_dir = '/etc/pki'
) {

  $ssl_file = $name

  File {
    ensure => present,
    owner  => 'root',
    group  => 'root'
  }

  file {
    $ssl_dir:
      mode => '0755'
  }

  file {
    "${ssl_dir}/${ssl_file}":
      mode    => '0644',
      content => $content;
  }
}
