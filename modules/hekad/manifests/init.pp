# hekad
class hekad(
  $config_dir = $hekad::params::config_dir,
  $version = $hekad::params::version,
) inherits hekad::params {
  file {
    $config_dir:
      ensure  => directory,
      purge   => true,
      recurse => true;
    ['/var/cache/hekad', '/var/cache/hekad/seekjournals']:
      ensure => directory;
  }

  package {
    'hekad3':
      ensure => absent;
    'heka':
      ensure  => $version;
  }

}
