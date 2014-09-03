# Creates zamboni settings file.
define marketplace::apps::zamboni::settings(
  $databases_default_url,
  $databases_slave_url,
  $api_access_secret_key = '',
  $broker_url = '',
  $builder_secret_key = '',
  $caches_default_location = '',
  $email_blacklist = '',
  $email_host = '',
  $es_hosts = '',
  $fxa_client_id = '',
  $fxa_client_secret = '',
  $fxa_oauth_url = '',
  $google_analytics_credentials = '{}',
  $google_api_credentials = '',
  $graphite_host = '127.0.0.1',
  $graphite_port = '2003',
  $graphite_prefix = 'zamboni-default',
  $heka_conf_sender_host = '127.0.0.1',
  $heka_conf_sender_port = '5565',
  $netapp_storage_root = '/tmp',
  $recaptcha_private_key = '',
  $recaptcha_public_key = '',
  $redirect_secret_key = '',
  $redis_backends_cache = '',
  $redis_backends_cache_slave = '',
  $redis_backends_master = '',
  $redis_backends_slave = '',
  $responsys_id = '',
  $services_database_url = '',
  $statsd_host = '127.0.0.1',
  $statsd_port = '8125',
  $statsd_prefix = 'zamboni-default',
  $addons_paypal_app_id = '',
  $addons_paypal_embedded_auth_user = '',
  $addons_paypal_embedded_password = '',
  $addons_paypal_embedded_signature = '',
  $addons_responsys_id = '',
  $addons_secret_key = '',
  $addons_sentry_dsn = '',
  $aws_access_key_id = '',
  $aws_secret_access_key = '',
  $aws_storage_bucket_name = '',
  $mkt_app_purchase_secret = '',
  $mkt_broker_url = '',
  $mkt_carrier_urls = '',
  $mkt_developers_oauth_key = '',
  $mkt_developers_oauth_secret = '',
  $mkt_inapp_key_path = '',
  $mkt_monolith_oauth_key = '',
  $mkt_monolith_oauth_secret = '',
  $mkt_monolith_password = '',
  $mkt_paypal_app_id = '',
  $mkt_paypal_chains_email = '',
  $mkt_paypal_embedded_auth_user = '',
  $mkt_paypal_embedded_password = '',
  $mkt_paypal_embedded_signature = '',
  $mkt_postfix_auth_token = '',
  $mkt_redis_backends_cache = '',
  $mkt_redis_backends_cache_slave = '',
  $mkt_redis_backends_master = '',
  $mkt_redis_backends_slave = '',
  $mkt_secret_key = '',
  $mkt_sentry_dsn = '',
  $mkt_signed_apps_reviewer_server = '',
  $mkt_signed_apps_server = '',
  $mkt_signing_server = '',
  $mkt_solitude_oauth_key = '',
  $mkt_solitude_oauth_secret = '',
  $mkt_webapps_receipt_key = '',
  $mkt_webapps_receipt_url = '',
  $mkt_webtrends_password = '',
  $mkt_webtrends_username = '',
  $mkt_whitelisted_clients_email_api = '[]',
  $secret_key = '',
  $addons_domain = undef,
  $addons_paypal_cgi_auth_password = '',
  $addons_paypal_cgi_auth_signature = '',
  $addons_paypal_cgi_auth_user = '',
  $addons_paypal_chains_email = '',
  $addons_paypal_email = '',
  $addons_paypal_embedded_auth_password = '',
  $addons_paypal_embedded_auth_signature = '',
  $addons_static_url = undef,
  $addons_webapps_receipt_key = '',
  $mkt_domain = undef,
  $mkt_bluevia_secret = '',
  $mkt_iarc_password = '',
  $mkt_paypal_cgi_auth_password = '',
  $mkt_paypal_cgi_auth_signature = '',
  $mkt_paypal_cgi_auth_user = '',
  $mkt_paypal_email = '',
  $mkt_paypal_embedded_auth_password = '',
  $mkt_paypal_embedded_auth_signature = '',
  $mkt_signed_apps_key = '',
  $mkt_static_url = undef,

  $cluster = undef,
  $env = undef,
) {
  $app_dir = $name
  if $cluster and $env {
    Marketplace::Overlay {
      app     => 'zamboni',
      cluster => $cluster,
      env     => $env,
    }
    marketplace::overlay {
      "zamboni::settings::${name}::sites":
        ensure   => directory,
        filename => 'sites';

      "zamboni::settings::${name}::sites/env":
        ensure   => directory,
        filename => "sites/${env}";

      "zamboni::settings::${name}/settings_local.py":
        content  => "sites.${env}.settings_mkt import *",
        filename => 'settings_local.py';

      "zamboni::settings::${name}/settings_local_mkt.py":
        content  => "sites.${env}.settings_mkt import *",
        filename => 'settings_local_mkt.py';

      "zamboni::settings::${name}/private_base.py":
        content  => template('marketplace/apps/zamboni/settings/private_base.py'),
        filename => "sites/${env}/private_base.py";

      "zamboni::settings::${name}/private_mkt.py":
        content  => template('marketplace/apps/zamboni/settings/private_mkt.py'),
        filename => "sites/${env}/private_mkt.py";
    }
  }

  file {
    "${app_dir}/private_base.py":
      content => template('marketplace/apps/zamboni/settings/private_base.py');

    "${app_dir}/private_addons.py":
      content => template('marketplace/apps/zamboni/settings/private_addons.py');

    "${app_dir}/private_mkt.py":
      content => template('marketplace/apps/zamboni/settings/private_mkt.py');
  }
}
