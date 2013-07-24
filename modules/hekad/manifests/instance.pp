# runs a heka
define hekad::instance(
    $config,
    $hekabin = '/usr/bin/hekad'
) {
    $heka_name = $name
    include hekad::params
    file {
        "${hekad::params::config_dir}/${heka_name}.toml":
            content => $config;
    }

    supervisord::service {
        "hekad-${heka_name}":
            user    => 'root',
            command => "${hekabin} -config=${hekad::params::config_dir}/${heka_name}.toml",
            app_dir => '/tmp',
            require => File["${hekad::params::config_dir}/${heka_name}.toml";
    }
}
