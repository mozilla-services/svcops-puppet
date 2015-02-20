# define admin instance for marketplace stats
define marketplace::apps::marketplace_stats::admin_instance(
  $cluster,
  $domain,
  $env,
  $ssh_key,
) {
  $project_dir = $name
  $codename = 'marketplace-stats'

  git::clone {
    "${project_dir}/marketplace-stats":
      repo => 'https://github.com/mozilla/marketplace-stats.git';
  }

  marketplace::apps::generic_js::deploysettings {
    "${project_dir}/marketplace-stats":
      cluster      => $cluster,
      domain       => $domain,
      env          => $env,
      project_name => $codename,
      ssh_key      => $ssh_key,
      require      => Git::Clone["${project_dir}/marketplace-stats"],
  }
}
