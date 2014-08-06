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
  $dreadnot_instance = undef,
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
  $scl_name = undef,
  $update_on_commit = false,
  $uwsgi = '', # should be string separated by ";"
) {
  require marketplace::apps::webpay::packages

  $app_dir = $name
  $codename = 'webpay'

  git::clone { "${app_dir}/webpay":
    repo => 'https://github.com/mozilla/webpay.git',
  }->


  file {
    "${app_dir}/webpay/deploysettings.py":
      content => template('marketplace/apps/webpay/admin/deploysettings.py');

    "${app_dir}/webpay/local.py":
      content => template('marketplace/apps/webpay/admin/settings_local.py');

    "${app_dir}/webpay/webpay/settings/sites/${env}/private_base.py":
      content => template('marketplace/apps/webpay/admin/private_base.py');
  }

  if $dreadnot_instance {
    dreadnot::stack { $domain:
      instance_name => $dreadnot_instance,
      github_url    => 'https://github.com/mozilla/webpay',
      git_url       => 'git://github.com/mozilla/webpay.git',
      project_dir   => "${app_dir}/webpay",
      require       => File["${app_dir}/webpay/deploysettings.py"],
    }
  }

  if $update_on_commit {
    go_freddo::branch { "${codename}_${domain}_${env}":
      app    => $codename,
      script => "/usr/local/bin/dreadnot.deploy -e ${env} ${domain}",
    }
  }
}
