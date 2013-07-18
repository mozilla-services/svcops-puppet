# $name is the location of geodude
define marketplace::apps::geodude::deploysettings(
    $cluster,
    $domain,
    $env,
    $ssh_key,
    $cron_name,
    $celery_service,
    $gunicorn = '', # should be string separated by ";"
    $multi_gunicorn = '', # should be string separated by ";"
    $uwsgi = '', # should be string separated by ";"
    $pyrepo = 'https://pyrepo.addons.mozilla.org/',
    $update_ref = false
) {
    $app_dir = $name

    file {
        "${app_dir}/deploysettings.py":
            content => template('marketplace/apps/geodude/deploysettings.py');
    }

}
