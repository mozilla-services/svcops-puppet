# solitude admin_instance
define marketplace::apps::solitude::admin_instance(
  $deploy_settings,
  $project_dir,
  $proxy_settings,
  $settings,
) {
  $solitude_name = $name

  create_resources(
    marketplace::apps::solitude::settings,
    {"${solitude_name}" => $settings},
    {'project_dir'      => $project_dir}
  )

  create_resources(
    marketplace::apps::solitude::proxy_settings,
    {"${solitude_name}" => $proxy_settings},
    {'project_dir'      => $project_dir}
  )

  create_resources(
    marketplace::apps::solitude::deploysettings,
    {"${project_dir}/solitude" => $settings}
  )
}
