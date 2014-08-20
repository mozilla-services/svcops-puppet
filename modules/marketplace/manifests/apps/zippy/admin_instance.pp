# $name is the location of zippy
define marketplace::apps::zippy::admin_instance(
  $cluster,
  $domain,
  $dreadnot_instance,
  $env,
  $ssh_key,
  $project_name = 'zippy',
  $update_on_commit = false,

  # app settings
  $oauth_key,
  $oauth_secret,
  $session_secret,
  $signature_key,

  $oauth_realm = 'Zippy',
) {
  $zippy_dir = $name
  $codename = 'zippy'

  git::clone { $zippy_dir:
    repo => 'https://github.com/mozilla/zippy.git',
  }->
  file {
    "${zippy_dir}/deploysettings.py":
      content => template('marketplace/apps/zippy/deploysettings.py');
    "${zippy_dir}/fabfile.py":
      content => template('marketplace/apps/zippy/fabfile.py');
    "${zippy_dir}/lib/config/local.js":
      content => template('marketplace/apps/zippy/local.js');
  }->
  dreadnot::stack {
    $domain:
      require       => File["${zippy_dir}/deploysettings.py"],
      instance_name => $dreadnot_instance,
      github_url    => 'https://github.com/mozilla/zippy',
      git_url       => 'git://github.com/mozilla/zippy.git',
      project_dir   => $zippy_dir;
  }

  if $update_on_commit {
    go_freddo::branch { "${codename}_${domain}_${env}":
      app    => $codename,
      script => "/usr/local/bin/dreadnot.deploy -e ${dreadnot_instance} ${domain}",
    }
  }
}
