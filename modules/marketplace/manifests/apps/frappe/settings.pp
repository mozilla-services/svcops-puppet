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
  $settings_dir = "${project_dir}/src/frappe_settings"

  file {
    "${project_dir}/requirements.prod.txt":
      content => template('marketplace/apps/frappe/admin/requirements.prod.txt');

    "${settings_dir}/local.py":
      content => template('marketplace/apps/frappe/admin/local.py');
  }
}
