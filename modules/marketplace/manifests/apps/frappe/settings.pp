# frappe settings
define marketplace::apps::frappe::settings(
  $caches_default_location,
  $codename,
  $cluster,
  $databases_default_url,
  $domain,
  $env,
  $project_dir,
  $secret_key,
  $sentry_dsn,
  $max_threads = '2',
) {
  $cache_prefix = md5($domain)
  $settings_dir = "${project_dir}/src/recommendation/settings"

  Marketplace::Overlay {
    app     => $codename,
    cluster => $cluster,
    env     => $env,
  }

  marketplace::overlay {
    "frappe::src::${name}":
      ensure   => 'directory',
      filename => 'src';

    "frappe::src::recommendation::${name}":
      ensure   => 'directory',
      filename => 'src/recommendation';

    "frappe::src::recommendation::settings::${name}":
      ensure   => 'directory',
      filename => 'src/recommendation/settings';

    "frappe::src::recommendation::settings::local::${name}":
      content  => template('marketplace/apps/frappe/admin/local.py'),
      filename => 'src/recommendation/settings/local.py';
  }

  file {
    "${settings_dir}/local.py":
      content => template('marketplace/apps/frappe/admin/local.py');
  }
}
