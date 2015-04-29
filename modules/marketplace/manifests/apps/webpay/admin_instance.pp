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
  $pyrepo = 'https://pyrepo.addons.mozilla.org/',
  $fxa_client_id = '',
  $fxa_client_secret = '',
  $update_ref = false,
  $mkt_oauth_key = '',
  $mkt_oauth_secret = '',
  $solitude_oauth_key = '',
  $solitude_oauth_secret = '',
  $statsd_host = '',
  $statsd_prefix = '',
  $uuid_hmac_key = '',
  $encrypted_cookie_key = '',
  $scl_name = undef,
  $uwsgi = '', # should be string separated by ";"
  $zamboni_shared_key = '',
) {
  require marketplace::apps::webpay::packages

  $app_dir = $name
  $codename = 'webpay'

  Marketplace::Overlay {
    app      => $codename,
    cluster  => $cluster,
    env      => $env,
  }

  marketplace::overlay {
    "${codename}::deploysettings::${name}":
      content  => template('marketplace/apps/webpay/admin/deploysettings.py'),
      filename => 'deploysettings.py';

    "${codename}::settings::${name}/webpay":
      ensure   => 'directory',
      filename => 'webpay';

    "${codename}::settings::${name}/webpay/settings":
      ensure   => 'directory',
      filename => 'webpay/settings';

    "${codename}::settings::${name}/webpay/settings/sites":
      ensure   => 'directory',
      filename => 'webpay/settings/sites';

    "${codename}::settings::${name}/webpay/settings/sites/env":
      ensure   => 'directory',
      filename => "webpay/settings/sites/${env}";

    "${codename}::settings::${name}/local.py":
      content  => "from .sites.${env}.settings_base import *\n",
      filename => 'webpay/settings/local.py';

    "${codename}::settings::${name}/private_base.py":
      content  => template('marketplace/apps/webpay/admin/private_base.py'),
      filename => "webpay/settings/sites/${env}/private_base.py";
  }
}
