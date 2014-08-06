# go freddo
class go_freddo(
  $apps = {},
  $port = '8882',
  $version = 'latest'
){
  $config_file = '/etc/go-freddo.toml'
  package {'go-freddo':
    ensure => $version,
  }->
  concat { $config_file: }

  create_resources(go_freddo::app, $apps)

  supervisord::service { 'go-freddo':
    app_dir   => '/tmp',
    command   => "/usr/bin/freddo -config '${config_file}' -bind ':${port}'",
    subscribe => Concat[$config_file],
    user      => 'root',
  }
}
