# solitude settings proxy
define marketplace::apps::solitude::proxy_settings(
  $bango_password,
  $bango_user,
  $cache_prefix,
  $email_host,
  $hmac_key,
  $project_dir,
  $secret_key,
  $sentry_dsn,
  $server_email,
  $site,
  $statsd_host,
  $statsd_port,
  $paypal_app_id = undef,
  $paypal_auth_password = undef,
  $paypal_auth_signature = undef,
  $paypal_auth_user = undef,
  $paypal_chains = undef,
  $boku_merchant_id = '',
  $boku_secret_key = '',
  $zippy_paas_key = undef,
  $zippy_paas_secret = undef,
  $cluster = undef,
  $env = undef,
) {
  $settings_dir = "${project_dir}/solitude/solitude/settings"

  if $cluster and $env {
    Marketplace::Overlay {
      app     => 'solitude-proxy',
      cluster => $cluster,
      env     => $env,
    }

    marketplace::overlay {
      "solitude::proxy_settings::${name}/solitude":
        ensure   => 'directory',
        filename => 'solitude';

      "solitude::proxy_settings::${name}/solitude/settings":
        ensure   => 'directory',
        filename => 'solitude/settings';

      "solitude::proxy_settings::${name}/solitude/settings/sites":
        ensure   => 'directory',
        filename => 'solitude/settings/sites';

      "solitude::proxy_settings::${name}/solitude/settings/sites/${site}":
        ensure   => 'directory',
        filename => "solitude/settings/sites/${site}";

      "solitude::proxy_settings::${name}/solitude/settings/local.py":
        content  => "from .sites.${site}.proxy import *\n",
        filename => 'solitude/settings/local.py';

      "solitude::proxy_settings::${name}/solitude/settings/sites/${site}/private_base.py":
        content  => template('marketplace/apps/solitude/proxy_settings.py'),
        filename => "solitude/settings/sites/${site}/private_base.py";
    }
  }

  file {
    "${settings_dir}/local.py":
      content => "from .sites.${site}.proxy import *\n";

    "${settings_dir}/sites/${site}/private_base.py":
      content => template('marketplace/apps/solitude/proxy_settings.py');
  }
}
