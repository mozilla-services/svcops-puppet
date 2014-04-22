# npmrepo
class npmrepo(
  $cache_dir = '/data/npmrepo',
  $npm_registry = 'https://registry.npmjs.org/',
  $server_name,
  $ttl = '7d',
){

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

    $server_name:
      content => template('npmrepo/npm-mirror.conf');
  }

}
