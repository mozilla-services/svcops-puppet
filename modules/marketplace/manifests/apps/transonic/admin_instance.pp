# $name is the location of transonic
define marketplace::apps::transonic::admin_instance(
  $cluster,
  $domain,
  $env,
  $ssh_key,
  $project_name = 'transonic',
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
