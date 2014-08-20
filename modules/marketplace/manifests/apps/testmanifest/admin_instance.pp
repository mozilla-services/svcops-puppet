# $name is the location of testmanifest
define marketplace::apps::testmanifest::admin_instance(
  $cluster,
  $domain,
  $dreadnot_instance,
  $env,
  $shared_storage_root,
  $ssh_key,
  $project_name = 'testmanifest',
  $update_on_commit = false,
  $user = 'nobody',
) {
  $testmanifest_dir = $name
  $codename = 'testmanifest'

  git::clone { $testmanifest_dir:
    repo => 'https://github.com/oremj/node-testmanifest.git',
  }->
  file { [
      $shared_storage_root,
      "${shared_storage_root}/manifests"
    ]:
      ensure => 'directory',
      owner  => $user;
  }->
  file {
    "${testmanifest_dir}/manifests":
      ensure => 'link',
      target => "${shared_storage_root}/manifests";
    "${testmanifest_dir}/deploysettings.py":
      content => template('marketplace/apps/testmanifest/deploysettings.py');
    "${testmanifest_dir}/fabfile.py":
      content => template('marketplace/apps/testmanifest/fabfile.py');
  }->
  dreadnot::stack {
    $domain:
      require       => File["${testmanifest_dir}/deploysettings.py"],
      instance_name => $dreadnot_instance,
      github_url    => 'https://github.com/oremj/node-testmanifest',
      git_url       => 'git://github.com/oremj/node-testmanifest.git',
      project_dir   => $testmanifest_dir;
  }

  if $update_on_commit {
    go_freddo::branch { "${codename}_${domain}_${env}":
      app    => $codename,
      script => "/usr/local/bin/dreadnot.deploy -e ${dreadnot_instance} ${domain}",
    }
  }
}
