# Creates zamboni settings file.
define marketplace::apps::olympia::admin_instance(
  $addons_paypal_app_id,
  $addons_paypal_embedded_auth_user,
  $addons_paypal_embedded_password,
  $addons_paypal_embedded_signature,
  $addons_responsys_id,
  $addons_secret_key,
  $addons_sentry_dsn,
  $api_access_secret_key,
  $broker_url,
  $builder_secret_key,
  $caches_default_location,
  $databases_default_url,
  $databases_slave_url,
  $email_blacklist,
  $email_host,
  $es_hosts,
  $google_analytics_credentials,
  $google_api_credentials,
  $graphite_host,
  $graphite_port,
  $graphite_prefix,
  $heka_conf_sender_host,
  $heka_conf_sender_port,
  $netapp_storage_root,
  $recaptcha_private_key,
  $recaptcha_public_key,
  $redirect_secret_key,
  $redis_backends_cache,
  $redis_backends_cache_slave,
  $redis_backends_master,
  $redis_backends_slave,
  $responsys_id,
  $services_database_url,
  $statsd_host,
  $statsd_port,
  $statsd_prefix,
  $aws_access_key_id = '',
  $aws_secret_access_key = '',
  $aws_storage_bucket_name = '',
  $email_qa_whitelist = '[]',
  $secret_key = '',
  $addons_paypal_cgi_auth_password = '',
  $addons_paypal_cgi_auth_signature = '',
  $addons_paypal_cgi_auth_user = '',
  $addons_paypal_chains_email = '',
  $addons_paypal_email = '',
  $addons_paypal_embedded_auth_password = '',
  $addons_paypal_embedded_auth_signature = '',
  $addons_static_url = undef,
  $addons_webapps_receipt_key = '',
  $celery_service_prefix = 'celeryd-addons-olympia-dev',
  $cluster = 'addons-dev',
  $cron_name = 'addons-olympia-dev',
  $cron_user = 'mkt_prod',
  $deploy_domain = undef,
  $dev = true,
  $domain = 'addons-olympia-dev.allizom.org',
  $env = 'dev',
  $pyrepo = 'https://pyrepo.addons.mozilla.org/',
  $scl_name = undef,
  $signing_server = '',
  $preliminary_signing_server = '',
  $ssh_key = undef,
  $update_ref = 'origin/master',
  $uwsgi = 'addons-olympia-dev',
) {
  $codename = 'olympia'
  $project_dir = $name
  $app_dir = "${project_dir}/olympia"

  if $deploy_domain {
    $deploy_domain_ = $deploy_domain
  }
  else {
    $deploy_domain_ = $domain
  }

  marketplace::apps::olympia::symlinks { $app_dir:
    cluster => $cluster,
    env     => $env,
    netapp  => $netapp_storage_root,
  }

  Marketplace::Overlay {
    app     => 'olympia',
    cluster => $cluster,
    env     => $env,
  }

  marketplace::overlay {
    "olympia::deploysettings::${name}":
      content  => template('marketplace/apps/olympia/deploysettings.py'),
      filename => 'deploysettings.py';

    "olympia::settings::${name}::sites":
      ensure   => 'directory',
      filename => 'sites';

    "olympia::settings::${name}::sites/env":
      ensure   => 'directory',
      filename => "sites/${env}";

    "olympia::settings::${name}/settings_local.py":
      content  => "from sites.${env}.settings_addons import *",
      filename => 'settings_local.py';

    "olympia::settings::${name}/private_base.py":
      content  => template('marketplace/apps/olympia/settings/private_base.py'),
      filename => "sites/${env}/private_base.py";

    "olympia::settings::${name}/private_addons.py":
      content  => template('marketplace/apps/olympia/settings/private_addons.py'),
      filename => "sites/${env}/private_addons.py";
  }
}
