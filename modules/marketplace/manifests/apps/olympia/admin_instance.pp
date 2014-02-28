# Creates zamboni settings file.
define marketplace::apps::olympia::admin_instance(
  $api_access_secret_key,
  $broker_url,
  $builder_secret_key,
  $caches_default_location,
  $databases_default_url,
  $databases_slave_url,
  $domain,
  $dreadnot_name,
  $dreadnot_instance,
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
  $addons_paypal_app_id,
  $addons_paypal_embedded_auth_user,
  $addons_paypal_embedded_password,
  $addons_paypal_embedded_signature,
  $addons_responsys_id,
  $addons_secret_key,
  $addons_sentry_dsn,
  $aws_access_key_id = '',
  $aws_secret_access_key = '',
  $aws_storage_bucket_name = '',
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
  $celery_service_prefix = 'addons-olympia-dev',
  $cron_user = 'mkt_prod',
  $dev = true,
  $env = 'dev',
  $cluster = 'addons-dev',
  $cron_name = 'addons-olympia-dev',
  $domain = 'addons-olympia-dev.allizom.org',
  $pyrepo = 'https://pyrepo.addons.mozilla.org/',
  $ssh_key = undef,
  $update_ref = 'origin/master',
  $uwsgi = 'addons-olympia-dev',
) {
  $project_dir = $name
  $app_dir = "${project_dir}/olympia"

  git::clone { $app_dir:
    repo => 'https://github.com/mozilla/olympia.git',
  }

  file {
    "${app_dir}/sites/${env}/private_base.py":
      require => Git::Clone[$app_dir],
      content => template('marketplace/apps/olympia/settings/private_base.py');

    "${app_dir}/sites/${env}/private_addons.py":
      require => Git::Clone[$app_dir],
      content => template('marketplace/apps/olympia/settings/private_addons.py');
  }

  dreadnot::stack { $dreadnot_name:
    instance_name => $dreadnot_instance,
    project_dir   => $app_dir,
    github_url    => 'https://github.com/mozilla/olympia',
    git_url       => 'https://github.com/mozilla/olympia.git',
  }

  file { "${app_dir}/deploysettings.py":
    require => Git::Clone[$app_dir],
    content => template('marketplace/apps/olympia/deploysettings.py');
  }
}
