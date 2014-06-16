# limits
define limits(
  $config = undef,
  $ensure = 'file',
){

  $limits_dir = '/etc/security/limits.d'

  file {
    "${limits_dir}/99-${name}.conf":
      ensure  => $ensure,
      content => template('limits/limits.conf'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
  }

}
