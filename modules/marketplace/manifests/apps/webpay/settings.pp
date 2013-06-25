# Creates zamboni settings file.
define marketplace::apps::webpay::settings(
    $env,
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
    $mkt_oauth_key = '',
    $mkt_oauth_secret = '',
    $solitude_oauth_key = '',
    $solitude_oauth_secret = '',
    $statsd_host = '',
    $statsd_prefix = '',
    $uuid_hmac_key = ''
) {
    $app_dir = $name
    file {
        "${app_dir}/local.py":
            content => template('marketplace/apps/webpay/settings/local.py');
        "${app_dir}}/settings/sites/${env}/private_base.py":
            content => template('marketplace/apps/webpay/settings/private_base.py');
    }
}
