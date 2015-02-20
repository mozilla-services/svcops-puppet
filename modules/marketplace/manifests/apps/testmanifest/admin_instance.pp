# $name is the location of testmanifest
define marketplace::apps::testmanifest::admin_instance(
  $cluster,
  $domain,
  $env,
  $shared_storage_root,
  $ssh_key,
  $project_name = 'testmanifest',
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
  }
}
