# solitude admin_instance
define marketplace::apps::solitude::admin_instance(
  $deploy_settings,
  $env,
  $project_dir,
  $settings,
  $is_proxy = false,
) {
  $solitude_name = $name
  $app_dir = "${project_dir}/solitude"

  git::clone { $app_dir:
    repo => 'https://github.com/mozilla/solitude.git',
  }

  if $is_proxy {
    $settings_type = 'marketplace::apps::solitude::proxy_settings'
  } else {
    $settings_type = 'marketplace::apps::solitude::settings'
  }
  create_resources(
    $settings_type,
    {"${solitude_name}" => $settings},
    {
      'project_dir' => $project_dir,
      'require'     => Git::Clone[$app_dir],
      'site'        => $env,
    }
  )

  create_resources(
    marketplace::apps::solitude::deploysettings,
    {"${project_dir}/solitude" => $deploy_settings},
    {
      'env'      => $env,
      'is_proxy' => $is_proxy,
      'require'     => Git::Clone[$app_dir],
    }
  )
}
