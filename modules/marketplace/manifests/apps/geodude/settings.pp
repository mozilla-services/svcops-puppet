# Creates geodude settings file.
define marketplace::apps::geodude::settings(
  $is_dev = 'False',
  $geo_db_path = 'GeoIP.dat',
  $allow_post = 'True'
) {
  $app_dir = $name
  file {
    "${app_dir}/geodude/settings.py":
      content => template('marketplace/apps/geodude/settings/settings.py');
  }
}
