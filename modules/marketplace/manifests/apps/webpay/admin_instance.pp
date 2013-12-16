# define admin instance for webpay
define marketplace::apps::webpay::admin_instance(
    $cluster,
    $domain,
    $env,
    $ssh_key,
    $cron_name,
    $celery_service,
    $database_default_url,
    $database_slave_url,
    $cache_prefix,
    $caches_default_location,
    $hmac_keys,
    $secret_key,
    $broker_url,
    $syslog_tag,
    $key,
    $secret,
    $sentry_dsn,
    $gunicorn = '', # should be string separated by ";"
    $multi_gunicorn = '', # should be string separated by ";"
    $uwsgi = '', # should be string separated by ";"
    $pyrepo = 'https://pyrepo.addons.mozilla.org/',
    $update_ref = false,
    $mkt_oauth_key = '',
    $mkt_oauth_secret = '',
    $solitude_oauth_key = '',
    $solitude_oauth_secret = '',
    $statsd_host = '',
    $statsd_prefix = '',
    $uuid_hmac_key = '',
    $encrypted_cookie_key = '',
    $scl_name = undef
) {
    $app_dir = $name

    file {
        "${app_dir}/webpay/deploysettings.py":
            content => template('marketplace/apps/webpay/admin/deploysettings.py');
    }

    file {
        "${app_dir}/webpay/local.py":
            content => template('marketplace/apps/webpay/admin/settings_local.py');

        "${app_dir}/webpay/webpay/settings/sites/${env}/private_base.py":
            content => template('marketplace/apps/webpay/admin/private_base.py');
    }
}
