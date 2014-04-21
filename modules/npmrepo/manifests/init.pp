# npmrepo
class npmrepo(
  $cache_dir = '/data/npmrepo',
  $npm_registry = 'https://registry.npmjs.org/',
  $ttl = '7d',
){
  $server_name = $name


  file {
    "${cache_dir}/data":
      ensure => 'directory',
      owner  => 'nginx';

    "${cache_dir}/tmp":
      ensure => 'directory',
      owner  => 'nginx';
  }

  nginx::config{
    'nginx-cache':
      content => template('npmrepo/nginx-cache.conf');
  }

  nginx::config{
    $server_name:
      content => template('npmrepo/npm-mirror.conf');
  }

}
