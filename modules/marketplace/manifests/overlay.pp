# add overlay
define marketplace::overlay(
  $app,
  $cluster,
  $env,

  $content = undef,
  $ensure = undef
) {
  require marketplace::overlays
  $filename = $name

  $root = "${marketplace::overlays::root}/${cluster}"
  $envdir = "${root}/${env}-${app}"

  if !defined(File[$root]) {
    file { $root:
      ensure => 'directory',
    }
  }
  if !defined(File[$envdir]) {
    file { $envdir:
      ensure => 'directory',
    }
  }

  file { "${envdir}/${filename}":
    ensure  => $ensure,
    content => $content,
  }
}
