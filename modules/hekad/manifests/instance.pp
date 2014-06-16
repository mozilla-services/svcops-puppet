# runs a heka
define hekad::instance(
  $config,
  $hekabin = '/usr/bin/hekad',
) {
  $heka_name = $name
  include hekad

  file { "${hekad::config_dir}/${heka_name}.toml":
      content => $config,
      require => Class['hekad'],
  }

  supervisord::service { "hekad-${heka_name}":
      app_dir   => '/tmp',
      command   => "${hekabin} -config=${hekad::config_dir}/${heka_name}.toml",
      subscribe => File["${hekad::config_dir}/${heka_name}.toml"],
      user      => 'root',
  }
}
