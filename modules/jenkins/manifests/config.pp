# jenkins config class
class jenkins::config(
  $memory_size  = false,
  $jenkins_port = '8080',
  $jenkins_handler_max = '50',
  $jenkins_handler_idle = '10',
){
  # allocate a quater of system memory to jvm
  if  $memory_size == false {
    $jvm_memory = inline_template('<%= @memorysize =~ /^(\d+)/; val = ( ( $1.to_i * 1024) / 4 ).to_i %>m')
  }
  else {
    $jvm_memory = $memory_size
  }

  # manage jenkins sysconfig
  file {
    '/etc/sysconfig/jenkins':
      owner   => 'root',
      group   => 'root',
      mode    => '0400',
      content => template('jenkins/sysconfig/jenkins');
  }
}
