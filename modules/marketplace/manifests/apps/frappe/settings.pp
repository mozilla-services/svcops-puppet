# frappe settings
define marketplace::apps::frappe::settings(
  $caches_default_location,
  $databases_default_url,
  $domain,
  $project_dir,
  $secret_key,
  $max_threads = '2',
) {
  $cache_prefix = md5($domain)
  $settings_dir = "${project_dir}/src/recommendation"

  file {
    "${settings_dir}/local.py":
      content => template('marketplace/apps/frappe/admin/local.py');
  }
}
