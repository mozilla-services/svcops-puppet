# $name is the location of geodude
define marketplace::apps::geodude::admin_instance(
  $cluster,
  $domain,
  $dreadnot_instance,
  $env,
  $ssh_key,
  $allow_post = 'True',
  $geo_db_format = 'mmdb',
  $geo_db_path = 'GeoIP2-City.mmdb',
  $is_dev = 'False',
  $project_name = 'geodude',
  $pyrepo = 'https://pyrepo.addons.mozilla.org/',
  $update_ref = undef,
  $update_on_commit = false,
  $uwsgi = 'geodude', # should be string separated by ";"
) {
  $geodude_dir = $name
  $codename = 'geodude'

  git::clone { $geodude_dir:
    repo => 'https://github.com/mozilla/geodude.git',
  }

  file {
    "${geodude_dir}/deploysettings.py":
      require => Git::Clone[$geodude_dir],
      content => template('marketplace/apps/geodude/deploysettings.py');
  }

  dreadnot::stack {
    $domain:
      require       => File["${geodude_dir}/deploysettings.py"],
      instance_name => $dreadnot_instance,
      github_url    => 'https://github.com/mozilla/geodude',
      git_url       => 'git://github.com/mozilla/geodude.git',
      project_dir   => $geodude_dir;
  }

  file {
    "${geodude_dir}/settings.py":
      content => template('marketplace/apps/geodude/settings/settings.py');
  }

  if $update_on_commit {
    go_freddo::branch { "${codename}_${domain}_${env}":
      app    => $codename,
      script => "/usr/local/bin/dreadnot.deploy -e ${dreadnot_instance} ${domain}",
    }
  }
}
