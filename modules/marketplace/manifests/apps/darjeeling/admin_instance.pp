# https://github.com/mozilla/darjeeling
define marketplace::apps::darjeeling::admin_instance(
  $cluster,
  $domain,
  $dreadnot_instance,
  $dreadnot_name,
  $env,
  $ssh_key,
) {
  $project_dir = $name
  $app_dir = "${project_dir}/darjeeling"

  $git_repo = 'https://github.com/mozilla/darjeeling'

  git::clone { $app_dir:
    repo => "${git_repo}.git",
  }

  dreadnot::stack { $dreadnot_name:
    instance_name => $dreadnot_instance,
    project_dir   => $app_dir,
    github_url    => $git_repo,
    git_url       => $git_repo,
  }

  file { "${app_dir}/deploysettings.py":
    require => Git::Clone[$app_dir],
    content => template('marketplace/apps/darjeeling/deploysettings.py');
  }
}
