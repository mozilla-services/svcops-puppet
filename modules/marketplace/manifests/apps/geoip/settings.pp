# Creates geoip settings file.
define marketplace::apps::geoip::settings(
    $is_dev = 'False',
    $geo_db_path = 'GeoIP.dat',
    $allow_post = 'True'
) {
    $app_dir = $name
    file {
        "${app_dir}/geoip/settings.py":
            content => template('marketplace/apps/geoip/settings/settings.py');
    }
}
