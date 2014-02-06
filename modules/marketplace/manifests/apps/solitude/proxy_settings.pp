# solitude settings proxy
define marketplace::apps::solitude::proxy_settings(
    $site,
    $project_dir,
    $secret_key,
    $hmac_key,
    $server_email,
    $email_host,
    $cache_prefix,
    $sentry_dsn,
    $bango_user,
    $bango_password,
    $paypal_app_id,
    $paypal_auth_user,
    $paypal_auth_password,
    $paypal_auth_signature,
    $paypal_chains,
    $statsd_host,
    $statsd_port,
    $zippy_paas_key=undef,
    $zippy_paas_secret=undef
) {
    $settings_dir = "${project_dir}/solitude/solitude/settings"
    file {
        "${settings_dir}/local.py":
            content => "from .sites.${site}.proxy import *\n";

        "${settings_dir}/sites/${site}/private_base.py":
            content => template('marketplace/apps/solitude/proxy_settings.py');
    }
}
