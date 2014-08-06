# solitude admin_instance
define marketplace::apps::solitude::admin_instance(
  $env,
  $project_dir,
  $settings,
  $deploy_settings = undef,
  $dreadnot_instance = undef,
  $is_proxy = false,
  $update_on_commit = false,
) {
  $solitude_name = $name
  $codename = 'solitude'
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

  if $deploy_settings {
    create_resources(
      marketplace::apps::solitude::deploysettings,
      {"${project_dir}/solitude" => $deploy_settings},
      {
        'env'      => $env,
        'is_proxy' => $is_proxy,
        'require'  => Git::Clone[$app_dir],
        'scl_name' => 'python27',
      }
    )
  }

  if $dreadnot_instance {
    dreadnot::stack { $solitude_name:
      instance_name => $dreadnot_instance,
      github_url    => 'https://github.com/mozilla/solitude',
      git_url       => 'git://github.com/mozilla/solitude.git',
      project_dir   => $app_dir,
    }
  }

  if $update_on_commit {
    go_freddo::branch { "${codename}_${solitude_name}_${env}":
      app    => $codename,
      script => "/usr/local/bin/dreadnot.deploy -e ${dreadnot_instance} ${solitude_name}",
    }
  }
}
