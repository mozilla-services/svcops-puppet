# marketplace::apps::olympia::celery_instance
define marketplace::apps::olympia::celery_instance(
  $app_dir = undef,
  $env = 'prod',
  $password = undef,
  $settings_module = 'settings_local',
  $scl = undef,
  $user = $olympia_private::mkt::any::prod::params::mkt_user,
  $workers = '6',
){

  # include olympia::apps::olympia::packages

  $olympia_dir = "${app_dir}/current/olympia"
  $olympia_python = "${app_dir}/current/venv/bin/python"
  $environ = "DJANGO_SETTINGS_MODULE=${settings_module},SPIDERMONKEY_INSTALLATION=/usr/bin/tracemonkey"

  Celery::Service {
    app_dir => $olympia_dir,
    command => 'standalone',
    environ => $environ,
    project => 'olympia',
    python  => $olympia_python,
    scl     => $scl,
    user    => $user,
    workers => $workers,
  }

  celery::service {
    "addons-olympia-${env}":
      args => '-Q celery';

    "addons-olympia-${env}-priority":
      args => '-Q priority,bulk';

    "addons-olympia-${env}-limited":
      args    => '-Q limited',
      workers => '4';

    "addons-olympia-${env}-devhub":
      args => '-Q devhub,images';
  }

  rabbitmq_user {
    "addons_olympia_${env}":
      admin    => false,
      password => $password,
      provider => 'rabbitmqctl';
  }

  rabbitmq_vhost {
    "addons_olympia_${env}":
      ensure   => 'present',
      provider => 'rabbitmqctl';
  }

  rabbitmq_user_permissions {
    "addons_olympia_${env}@addons_olympia_${env}":
      configure_permission => '.*',
      read_permission      => '.*',
      write_permission     => '.*',
      provider             => 'rabbitmqctl';
  }
}
