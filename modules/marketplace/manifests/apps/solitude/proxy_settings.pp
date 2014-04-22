# solitude settings proxy
define marketplace::apps::solitude::proxy_settings(
  $bango_password,
  $bango_user,
  $boku_merchant_id = '',
  $boku_secret_key = '',
  $cache_prefix,
  $email_host,
  $hmac_key,
  $paypal_app_id,
  $paypal_auth_password,
  $paypal_auth_signature,
  $paypal_auth_user,
  $paypal_chains,
  $project_dir,
  $secret_key,
  $sentry_dsn,
  $server_email,
  $site,
  $statsd_host,
  $statsd_port,
  $zippy_paas_key=undef,
  $zippy_paas_secret=undef,
) {
  $settings_dir = "${project_dir}/solitude/solitude/settings"
  file {
    "${settings_dir}/local.py":
      content => "from .sites.${site}.proxy import *\n";

    "${settings_dir}/sites/${site}/private_base.py":
      content => template('marketplace/apps/solitude/proxy_settings.py');
  }
}
