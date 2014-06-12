# modprobe::persistent
define modprobe::persistent(
  $ensure = 'file',
){

  $mod_dir = '/etc/sysconfig/modules'
  $mod_name = $name

  file {
    "${mod_dir}/${mod_name}.modules":
      ensure  => $ensure,
      content => template('modprobe/template.modules'),
      mode    => '0755',
  }

  exec {
    "modprobe-${mod_name}":
      command => "/sbin/modprobe ${mod_name}",
      unless  => "/sbin/lsmod | /bin/grep ${mod_name} 2>/dev/null",
  }

}
