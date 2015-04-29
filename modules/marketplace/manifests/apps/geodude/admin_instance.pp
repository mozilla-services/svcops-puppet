# $name is the location of geodude
define marketplace::apps::geodude::admin_instance(
  $cluster,
  $domain,
  $env,
  $ssh_key,
  $allow_post = 'True',
  $geo_db_format = 'mmdb',
  $geo_db_path = 'GeoIP2-City.mmdb',
  $is_dev = 'False',
  $project_name = 'geodude',
  $pyrepo = 'https://pyrepo.addons.mozilla.org/',
  $update_ref = undef,
  $uwsgi = 'geodude', # should be string separated by ";"
) {
  $geodude_dir = $name
  $codename = 'geodude'

  Marketplace::Overlay {
    app     => $project_name,
    cluster => $cluster,
    env     => $env,
  }

  marketplace::overlay {
    "geodude::deploysettings::${name}":
      content  => template('marketplace/apps/geodude/deploysettings.py'),
      filename => 'deploysettings.py';

    "geodude::settings::${name}":
      content  => template('marketplace/apps/geodude/settings/settings.py'),
      filename => 'settings.py';
  }
}
