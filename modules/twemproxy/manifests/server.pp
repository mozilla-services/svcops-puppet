# start a twemproxy server.
define twemproxy::server(
  $pools = {},
  $stats_port = 22222
) {
  include twemproxy
  include concat::setup

  $server_name = $name
  $service_name = "twemproxy-${server_name}"
  $config_file = "${twemproxy::config_dir}/${server_name}.yml"
  $pool_defaults = {
    'server_name' => $server_name,
    'before'      => Supervisord::Service[$service_name]
  }

  concat {
    $config_file:
      owner => root,
      group => root,
      mode  => '0644';
  }

  create_resources(twemproxy::pool, $pools, $pool_defaults)

  supervisord::service {
    $service_name:
      command => "/usr/sbin/nutcracker -c \"${config_file}\" -s ${stats_port}",
      app_dir => '/tmp',
      user    => 'nobody';
  }
}
