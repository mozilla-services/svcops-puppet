# $name is the location of zamboni
define marketplace::apps::zamboni::deploysettings(
  $cluster,
  $domain,
  $env,
  $ssh_key,
  $cron_name,
  $celery_service_mkt_prefix,
  $celery_service_prefix = false,
  $cron_user = 'mkt_prod',
  $dev = false,
  $load_testing = 'False', # must be a python boolean
  $pyrepo = 'https://pyrepo.addons.mozilla.org/',
  $scl_name = undef,
  $update_ref = false,
  $uwsgi = '', # should be string separated by ";"
) {
  $zamboni_dir = $name

  marketplace::overlay { "zamboni::deploysettings::${name}":
    app      => 'zamboni',
    cluster  => $cluster,
    content  => template('marketplace/apps/zamboni/deploysettings.py'),
    env      => $env,
    filename => 'deploysettings.py',
  }

  file { "${zamboni_dir}/deploysettings.py":
    content => template('marketplace/apps/zamboni/deploysettings.py'),
  }

}
