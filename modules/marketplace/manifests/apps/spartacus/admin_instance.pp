# $name is the location of spartacus
define marketplace::apps::spartacus::admin_instance(
  $cluster,
  $domain,
  $dreadnot_instance,
  $env,
  $ssh_key,
  $scl_name = 'python27',
  $webpay_dir = '',

  $project_name = 'spartacus',
  $update_on_commit = false,
) {
  $spartacus_dir = $name
  $codename = 'spartacus'

  git::clone { $spartacus_dir:
    repo => 'https://github.com/mozilla/spartacus.git',
  }

  file {
    "${spartacus_dir}/deploysettings.py":
      require => Git::Clone[$spartacus_dir],
      content => template('marketplace/apps/spartacus/deploysettings.py');
  }

  dreadnot::stack {
    $domain:
      require       => File["${spartacus_dir}/deploysettings.py"],
      instance_name => $dreadnot_instance,
      github_url    => 'https://github.com/mozilla/spartacus',
      git_url       => 'git://github.com/mozilla/spartacus.git',
      project_dir   => $spartacus_dir;
  }

  if $update_on_commit {
    go_freddo::branch { "${codename}_${domain}_${env}":
      app    => $codename,
      script => "/usr/local/bin/dreadnot.deploy -e dev ${domain}",
    }
  }
}
