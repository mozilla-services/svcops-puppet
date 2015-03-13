# $name is the location of operator_dashboard
define marketplace::apps::marketplace_operator_dashboard::admin_instance(
  $cluster,
  $domain,
  $env,
  $ssh_key,
  $project_name = 'marketplace-operator-dashboard',
  $zamboni_dir = undef,
) {
  $project_dir = $name

  marketplace::apps::commonplace::deploysettings {
    "${project_dir}/${project_name}":
      cluster      => $cluster,
      domain       => $domain,
      env          => $env,
      project_name => $project_name,
      ssh_key      => $ssh_key,
      zamboni_dir  => $zamboni_dir,
  }
}
