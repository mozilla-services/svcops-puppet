# define ssl resource
define ssl::resource(
  $content,
  $ssl_dir = '/etc/pki'
) {

  $ssl_file = $name

  file {
    "${ssl_dir}/${ssl_file}":
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => $content;
  }
}
