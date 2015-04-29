# $name is the location of solitude
define marketplace::apps::solitude::deploysettings(
  $cluster,
  $domain,
  $env,
  $ssh_key,
  $cron_name = 'sol.prod',
  $cron_user = 'sol_prod',
  $uwsgi = '', # should be string separated by ";"
  $pyrepo = 'https://pyrepo.addons.mozilla.org/',
  $web_role = 'web',
  $is_proxy = false,
  $scl_name = undef
) {
  $solitude_dir = $name

  $app = $is_proxy ? {
    true    => 'solitude-proxy',
    default => 'solitude',
  }

  Marketplace::Overlay {
    app     => $app,
    cluster => $cluster,
    env     => $env,
  }

  marketplace::overlay {
    "solitude::deploysettings::${name}":
      content  => template('marketplace/apps/solitude/deploysettings.py'),
      filename => 'deploysettings.py';
  }
}
