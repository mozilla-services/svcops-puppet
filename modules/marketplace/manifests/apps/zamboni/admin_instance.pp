# zamboni admin instance
# name is the project dir
define marketplace::apps::zamboni::admin_instance(
  $cluster,
  $domain,
  $env,
  $dreadnot_instance,
  $deploy_settings, # zamboni::deploysettings hash
  $netapp_root,
  $settings, # zamboni::settings hash
  $ssh_key,
) {
  $instance_name = $name
  $project_dir = "/data/${cluster}/src/${domain}"
  $app_dir = "${project_dir}/zamboni"

  git::clone { $app_dir:
    repo => 'https://github.com/mozilla/zamboni.git',
  }

  create_resources(
    marketplace::apps::zamboni::settings,
    {$app_dir => $settings},
    {require  => Git::Clone[$app_dir]}
  )

  create_resources(
    marketplace::apps::zamboni::deploysettings,
    {$app_dir => $deploy_settings},
    {
      require  => Git::Clone[$app_dir],
      env     => $env,
      cluster => $cluster,
      domain  => $domain,
      ssh_key => $ssh_key,
    }
  )

  marketplace::apps::fireplace::admin_instance { "${project_dir}-fireplace/fireplace":
    cluster           => $cluster,
    domain            => "${domain}-fireplace",
    dreadnot_instance => $dreadnot_instance,
    env               => $env,
    ssh_key           => $ssh_key,
  }

  marketplace::apps::zamboni::symlinks { $app_dir:
    require => Git::Clone[$app_dir],
    netapp  => $netapp_root,
  }

  marketplace::apps::zamboni::symlinks::fireplace { $app_dir:
    require       => Git::Clone[$app_dir],
    fireplace_dir => "${project_dir}-fireplace",
  }
}
