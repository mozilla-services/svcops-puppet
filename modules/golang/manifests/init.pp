# installs golang packages.
class golang(
  $ensure = 'present'
){
  $env_ensure = $ensure ? {
    'absent' => 'absent',
    default  => 'present'
  }
  package {
    'golang-env':
      ensure => $env_ensure;
    'golang':
      ensure => $ensure;
  }
}
