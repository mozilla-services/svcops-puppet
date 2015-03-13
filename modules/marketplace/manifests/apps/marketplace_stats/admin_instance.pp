# define admin instance for marketplace stats
define marketplace::apps::marketplace_stats::admin_instance(
  $cluster,
  $domain,
  $env,
  $ssh_key,
  $project_name = 'marketplace-stats',
  $zamboni_dir = hiera('marketplace::zamboni_dir')
) {
  $project_dir = $name

  marketplace::apps::commonplace::deploysettings {
    "${project_dir}/${project_name}":
      cluster      => $cluster,
      domain       => $domain,
      env          => $env,
      project_name => $project_name,
      ssh_key      => $ssh_key,
      zamboni_dir  => $zamboni_dir[$env],
  }
}
