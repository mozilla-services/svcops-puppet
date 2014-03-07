# solitude settings
define marketplace::apps::solitude::settings(
    $site,
    $project_dir,
    $db_url,
    $db_url_slave,
    $secret_key,
    $hmac_key,
    $server_email,
    $email_host,
    $memcache_hosts,
    $cache_prefix,
    $solitude_proxy,
    $sentry_dsn,
    $paypal_url_whitelist,
    $aes_key_dir,
    $statsd_host,
    $statsd_port,
    $webpay_oauth_secret,
    $mkt_oauth_secret,
    $bango_basic_auth,
    $s3_auth_key='',
    $s3_auth_secret='',
    $s3_bucket=''
) {
    $settings_dir = "${project_dir}/solitude/solitude/settings"
    file {
        "${settings_dir}/local.py":
            content => "from .sites.${site}.db import *\n";

        "${settings_dir}/sites/${site}/private_base.py":
            content => template('marketplace/apps/solitude/settings.py');
    }
}
