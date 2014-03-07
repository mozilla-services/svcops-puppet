# solitude admin_instance
define marketplace::apps::solitude::admin_instance(
  $deploy_settings,
  $env,
  $project_dir,
  $settings,
) {
  $solitude_name = $name

  create_resources(
    marketplace::apps::solitude::settings,
    {"${solitude_name}" => $settings},
    {
      'project_dir' => $project_dir,
      'site'        => $env,
    }
  )

  create_resources(
    marketplace::apps::solitude::deploysettings,
    {"${project_dir}/solitude" => $settings},
    {
      'env'      => $env,
      'is_proxy' => false,
    }
  )
}
