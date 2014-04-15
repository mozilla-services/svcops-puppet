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
  $settings_site,
  $ssh_key,
) {
  $instance_name = $name
  $project_dir = "/data/${cluster}/src/${domain}"
  $app_dir = "${project_dir}/zamboni"

  git::clone { $app_dir:
    repo => 'https://github.com/mozilla/zamboni.git',
  }

  file {
    "${app_dir}/settings_local.py":
      require => Git::Clone[$app_dir],
      content => "from sites.${settings_site}.settings_addons import *";
    "${app_dir}/settings_local_mkt.py":
      require => Git::Clone[$app_dir],
      content => "from sites.${settings_site}.settings_mkt import *";
  }

  create_resources(
    marketplace::apps::zamboni::settings,
    {"${app_dir}/sites/${settings_site}" => $settings},
    {
      require             => Git::Clone[$app_dir],
      netapp_storage_root => $netapp_root,
    }
  )

  create_resources(
    marketplace::apps::zamboni::deploysettings,
    {"${app_dir}" => $deploy_settings},
    {
      require  => Git::Clone[$app_dir],
      env     => $env,
      cluster => $cluster,
      domain  => $domain,
      ssh_key => $ssh_key,
    }
  )

  marketplace::apps::fireplace::admin_instance { "${project_dir}/fireplace":
    cluster           => $cluster,
    domain            => "${domain}-fireplace",
    dreadnot_instance => $dreadnot_instance,
    env               => $env,
    ssh_key           => $ssh_key,
  }

  dreadnot::stack { $domain:
    github_url    => 'https://github.com/mozilla/zamboni',
    git_url       => 'git://github.com/mozilla/zamboni.git',
    instance_name => $dreadnot_instance,
    project_dir   => $app_dir,
  }

  marketplace::apps::zamboni::symlinks { $app_dir:
    require => Git::Clone[$app_dir],
    netapp  => $netapp_root,
  }

  marketplace::apps::zamboni::symlinks::fireplace { $app_dir:
    require       => Git::Clone[$app_dir],
    fireplace_dir => "/data/${cluster}/www/${domain}-fireplace/current",
  }
}
