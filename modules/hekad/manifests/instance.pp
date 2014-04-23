# runs a heka
define hekad::instance(
  $config,
  $hekabin = '/usr/bin/hekad'
) {
  $heka_name = $name
  include hekad

  file {
    "${hekad::config_dir}/${heka_name}.toml":
      require => Class['hekad'],
      content => $config;
  }

  supervisord::service {
    "hekad-${heka_name}":
      user    => 'root',
      command => "${hekabin} -config=${hekad::config_dir}/${heka_name}.toml",
      app_dir => '/tmp',
      require => File["${hekad::config_dir}/${heka_name}.toml"];
  }
}
