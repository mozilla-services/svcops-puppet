# $name is the location of zippy
define marketplace::apps::zippy::admin_instance(
  $cluster,
  $domain,
  $env,
  $ssh_key,
  $project_name = 'zippy',

  # app settings
  $oauth_key,
  $oauth_secret,
  $session_secret,
  $signature_key,

  $oauth_realm = 'Zippy',

  $redis_host = 'redis-dev-master',
  $redis_port = '6379',
) {
  $zippy_dir = $name
  $codename = 'zippy'

  Marketplace::Overlay {
    app      => $codename,
    cluster  => $cluster,
    env      => $env,
  }
  marketplace::overlay {
    "${codename}::deploysettings::${name}":
      content  => template('marketplace/apps/zippy/deploysettings.py'),
      filename => 'deploysettings.py';

    "${codename}::settings::${name}/fabfile.py":
      content  => template('marketplace/apps/zippy/fabfile.py'),
      filename => 'fabfile.py';

    "${codename}::settings::${name}/lib":
      ensure   => 'directory',
      filename => 'lib';

    "${codename}::settings::${name}/lib/config":
      ensure   => 'directory',
      filename => 'lib/config';

    "${codename}::settings::${name}/local.js":
      content  => template('marketplace/apps/zippy/local.js'),
      filename => 'lib/config/local.js';
  }
}
