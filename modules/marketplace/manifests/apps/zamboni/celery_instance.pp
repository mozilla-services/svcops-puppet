# marketplace::apps::zamboni::celery_instance
define marketplace::apps::zamboni::celery_instance(
    $addons_password = undef,
    $app_dir = undef,
    $env = 'prod',
    $marketplace_password = undef,
    $settings_module = 'settings_local_mkt',
    $user = $marketplace_private::mkt::any::prod::params::mkt_user,
    $workers = '24',
){

    include marketplace::apps::zamboni::packages
    include marketplace::apps::zamboni::packages::celery

    $zamboni_dir = "${app_dir}/current/zamboni"
    $zamboni_python = "${app_dir}/current/venv/bin/python"
    $environ = "DJANGO_SETTINGS_MODULE=${settings_module},SPIDERMONKEY_INSTALLATION=/usr/bin/tracemonkey"

    Celery::Service {
        app_dir => $zamboni_dir,
        python  => $zamboni_python,
        workers => $workers,
        user    => $user,
        environ => $environ,
    }

    celery::service {
        "marketplace-${env}":
            args => '-Q celery';

        "marketplace-${env}-priority":
            args => '-Q priority,bulk';

        "marketplace-${env}-limited":
            args    => '-Q limited',
            workers => '2';

        "marketplace-${env}-devhub":
            args => '-Q devhub,images';

    }

    rabbitmq_user {
        "marketplace_${env}":
            admin    => false,
            password => $marketplace_password,
            provider => 'rabbitmqctl';
    }

    rabbitmq_vhost {
        [
            "marketplace_${env}",
        ]:
            ensure   => present,
            provider => 'rabbitmqctl';
    }

    rabbitmq_user_permissions {
        "marketplace_${env}@marketplace_${env}":
            configure_permission => '.*',
            read_permission      => '.*',
            write_permission     => '.*',
            provider             => 'rabbitmqctl';
    }
}
