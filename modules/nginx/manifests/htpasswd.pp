# define nginx htpasswd
define nginx::htpasswd (
  $auth_users
){
  file {
    "/etc/nginx/conf.d/${name}.htpasswd":
      ensure  => 'file',
      content => template('nginx/htpasswd'),
      owner   => 'nginx',
      mode    => '0600',
  }
}
