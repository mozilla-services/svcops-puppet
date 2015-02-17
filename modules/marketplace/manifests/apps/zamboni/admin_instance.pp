# zamboni admin instance
# name is the project dir
define marketplace::apps::zamboni::admin_instance(
  $aeskeys,
  $cluster,
  $deploy_settings, # zamboni::deploysettings hash
  $domain,
  $dreadnot_instance,
  $env,
  $netapp_root,
  $settings, # zamboni::settings hash
  $settings_site,
  $ssh_key,
  $update_on_commit = false,
  $webpay_settings = undef,
  $scl = undef,
) {
  $instance_name = $name
  $codename = 'zamboni'
  $project_dir = "/data/${cluster}/src/${domain}"
  $app_dir = "${project_dir}/${codename}"

  git::clone { $app_dir:
    repo => 'https://github.com/mozilla/zamboni.git',
  }

  file {
    "${app_dir}/settings_local.py":
      require => Git::Clone[$app_dir],
      content => "from sites.${settings_site}.settings_mkt import *";
    "${app_dir}/settings_local_mkt.py":
      require => Git::Clone[$app_dir],
      content => "from sites.${settings_site}.settings_mkt import *";
  }

  create_resources(
    marketplace::apps::zamboni::settings,
    {"${app_dir}/sites/${settings_site}" => $settings},
    {
      require                 => Git::Clone[$app_dir],
      cluster                 => $cluster,
      env                     => $env,
      netapp_storage_root     => $netapp_root,
      preverified_account_key => regsubst("${project_dir}/current/aeskeys/preverified_account.key", 'src', 'www'),
    }
  )

  Marketplace::Apps::Zamboni::Aeskeys {
    cluster => $cluster,
    env     => $env,
  }

  create_resources(
    marketplace::apps::zamboni::aeskeys,
    {"${project_dir}" => $aeskeys},
  )

  create_resources(
    marketplace::apps::zamboni::deploysettings,
    {"${app_dir}" => $deploy_settings},
    {
      require                   => Git::Clone[$app_dir],
      celery_service_mkt_prefix => "celeryd-marketplace-${env}",
      cluster                   => $cluster,
      cron_name                 => "zamboni-${env}",
      domain                    => $domain,
      env                       => $env,
      ssh_key                   => $ssh_key,
      scl                       => $scl,
    }
  )

  if $webpay_settings {
    create_resources(
      marketplace::apps::webpay::admin_instance,
      {"${project_dir}-webpay" => $webpay_settings},
      {
        cache_prefix      => "${env}.webpay",
        celery_service    => "celeryd-webpay-${env}",
        cluster           => $cluster,
        cron_name         => "webpay-${env}",
        domain            => "${domain}-webpay",
        dreadnot_instance => $dreadnot_instance,
        env               => $env,
        scl_name          => 'python27',
        ssh_key           => $ssh_key,
        statsd_prefix     => "webpay-${env}",
        syslog_tag        => "http_app_webpay_${env}",
        update_on_commit  => $update_on_commit,
        uwsgi             => "webpay-${env}"
      }
    )
  }

  marketplace::apps::fireplace::admin_instance { "${project_dir}/fireplace":
    cluster           => $cluster,
    domain            => "${domain}-fireplace",
    dreadnot_instance => $dreadnot_instance,
    env               => $env,
    ssh_key           => $ssh_key,
    update_on_commit  => $update_on_commit,
    zamboni_dir       => regsubst("${project_dir}/current", 'src', 'www'),
  }

  marketplace::apps::transonic::admin_instance { "${project_dir}/transonic":
    cluster           => $cluster,
    domain            => "${domain}-transonic",
    dreadnot_instance => $dreadnot_instance,
    env               => $env,
    ssh_key           => $ssh_key,
    update_on_commit  => $update_on_commit,
  }

  marketplace::apps::marketplace_operator_dashboard::admin_instance { "${project_dir}/marketplace-operator-dashboard":
    cluster           => $cluster,
    domain            => "${domain}-marketplace-operator-dashboard",
    dreadnot_instance => $dreadnot_instance,
    env               => $env,
    ssh_key           => $ssh_key,
    update_on_commit  => $update_on_commit,
  }

  marketplace::apps::spartacus::admin_instance { "${project_dir}/spartacus":
    cluster           => $cluster,
    domain            => "${domain}-spartacus",
    dreadnot_instance => $dreadnot_instance,
    env               => $env,
    ssh_key           => $ssh_key,
    update_on_commit  => $update_on_commit,
    webpay_dir        => "${project_dir}-webpay",
  }

  dreadnot::stack { $domain:
    github_url    => 'https://github.com/mozilla/zamboni',
    git_url       => 'git://github.com/mozilla/zamboni.git',
    instance_name => $dreadnot_instance,
    project_dir   => $app_dir,
  }

  if $update_on_commit {
    go_freddo::branch { "${codename}_${domain}_${env}":
      app    => $codename,
      script => "/usr/local/bin/dreadnot.deploy -e ${dreadnot_instance} ${domain}",
    }
  }

  marketplace::apps::zamboni::symlinks { $app_dir:
    require => Git::Clone[$app_dir],
    netapp  => $netapp_root,
  }

  marketplace::apps::zamboni::symlinks::fireplace { $app_dir:
    require       => Git::Clone[$app_dir],
    cluster       => $cluster,
    env           => $env,
    fireplace_dir => "/data/${cluster}/www/${domain}-fireplace/current",
  }

  marketplace::apps::zamboni::symlinks::discoplace { $app_dir:
    discoplace_dir => "/data/${cluster}/www/${domain}-discoplace/current",
  }

  marketplace::apps::zamboni::symlinks::transonic { $app_dir:
    transonic_dir => "/data/${cluster}/www/${domain}-transonic/current",
  }

  marketplace::apps::zamboni::symlinks::marketplace_operator_dashboard { $app_dir:
    marketplace_operator_dashboard_dir => "/data/${cluster}/www/${domain}-marketplace-operator-dashboard/current",
  }
}
