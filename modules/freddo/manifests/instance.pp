# configure freddo
define freddo::instance(
    $location
) {
    include supervisord::base
    $freddo_name = "${name}-updater"
    supervisord::service {
        $freddo_name:
            command => "/usr/bin/python ${location}/manage.py celeryd --loglevel=INFO -f /var/log/${freddo_name}.log -c 6",
            app_dir => $location,
            user    => 'root';
    }
}
