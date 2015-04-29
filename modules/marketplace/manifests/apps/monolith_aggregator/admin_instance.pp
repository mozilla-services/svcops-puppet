# define admin instance for monolith aggregator
define marketplace::apps::monolith_aggregator::admin_instance(
  $mkt_endpoint,
  $mkt_transaction_endpoint,
  $db_uri,
  $es_url,
  $es_index_prefix,
  $ga_auth,
  $mkt_user,
  $mkt_pass,
  $solitude_access_key,
  $solitude_secret_key,
  $solitude_bucket,
  $cluster,
  $domain,
  $env,
  $ssh_key,
  $log_level = 'debug',
  $es_index_prefix = undef,
  $cron_user = 'mkt_prod_monolith',
  $pyrepo = 'https://pyrepo.addons.mozilla.org/',
) {
  $codename = 'monolith-aggregator'
  $project_dir = $name
  $installed_dir = regsubst($project_dir, 'src', 'www')
  git::clone {
    "${project_dir}/monolith-aggregator":
      repo => 'https://github.com/mozilla/monolith-aggregator.git';

  }


  $log_file = "/var/log/${domain}.log"

  # make sure log file is owned by the cron user
  file {
    $log_file:
      ensure => present,
      owner  => $cron_user
  }

  cron {
    "aggr-${project_dir}":
      environment => 'MAILTO=amo-developers@mozilla.org',
      command     => "cd ${installed_dir}/current/monolith-aggregator; ../venv/bin/monolith-extract aggregator.ini --log-level ${log_level} --start-date `/bin/date --date='yesterday' +'\\%Y-\\%m-\\%d'` --end-date `/bin/date --date='yesterday' +'\\%Y-\\%m-\\%d'` > ${log_file} 2>&1",
      user        => $cron_user,
      hour        => 9,
      minute      => 15;
  }

  Marketplace::Overlay {
    app     => 'monolith-aggregator',
    cluster => $cluster,
    env     => $env,
  }

  marketplace::overlay {
    "monolith_aggregator::deploysettings::${name}":
      content  => template('marketplace/apps/monolith/deploysettings.py'),
      filename => 'deploysettings.py';

    "monolith_aggregator::setttings::aggregator::${name}":
      content  => template('marketplace/apps/monolith_aggregator/admin/aggregator.ini'),
      filename => 'aggregator.ini';

    "monolith_aggregator::setttings::auth::${name}":
      content  => $ga_auth,
      filename => 'auth.json';

    "monolith_aggregator::setttings::password::${name}":
      content  => template('marketplace/apps/monolith_aggregator/admin/monolith.password.ini'),
      filename => 'monolith.password.ini';

    "monolith_aggregator::setttings::solitude_aws::${name}":
      content  => template('marketplace/apps/monolith_aggregator/admin/solitude_aws_keys.ini'),
      filename => 'solitude_aws_keys.ini';
  }
}
