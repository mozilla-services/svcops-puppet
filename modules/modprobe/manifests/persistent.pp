# modprobe::persistent
define modprobe::persistent(
  $ensure = 'file',
){

  $module_dir = '/etc/sysconfig/modules'
  $module_name = $name

  file {
    "${module_dir}/${module_name}.modules":
      ensure  => $ensure,
      content => template('modprobe/template.modules'),
      mode    => '0755',
  }

  exec {
    "modprobe-${module_name}":
      command => "/sbin/modprobe ${module_name}",
      unless  => "/sbin/lsmod | /bin/grep ${module_name} 2>/dev/null",
  }

}
