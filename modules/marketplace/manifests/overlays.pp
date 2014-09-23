# add overlay directory
class marketplace::overlays {
  $root = '/data/overlays'
  file { $root:
    ensure => 'directory',
  }
}
