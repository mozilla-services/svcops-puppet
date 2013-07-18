# $name is the location of webpay
define marketplace::apps::webpay::deploysettings(
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
    $webpay_dir = $name

    file {
        "${webpay_dir}/deploysettings.py":
            content => template('marketplace/apps/webpay/deploysettings.py');
    }

}
