# marketplace::apps::zamboni::celery_instance
define marketplace::apps::zamboni::celery_instance(
    $app_dir = undef,
    $marketplace_password = undef,
    $addons_password = undef,
    $env = 'prod',
    $workers = '24',
    $user = $marketplace_private::mkt::any::prod::params::mkt_user
){

    include marketplace::apps::zamboni::packages
    include marketplace::apps::zamboni::packages::celery

    $zamboni_dir = "${app_dir}/current/zamboni"
    $zamboni_python = "${app_dir}/current/venv/bin/python"
    $environ = 'SPIDERMONKEY_INSTALLATION=/usr/bin/tracemonkey'

    Celery::Service {
        app_dir => $zamboni_dir,
        python  => $zamboni_python,
        workers => $workers,
        user    => $user,
        environ => $environ,
    }

    celery::service {
        "marketplace-${env}":
            args => '-Q celery --settings=settings_local_mkt';

        "marketplace-${env}-priority":
            args => '-Q priority,bulk --settings=settings_local_mkt';

        "marketplace-${env}-limited":
            args    => '-Q limited --settings=settings_local_mkt',
            workers => '2';

        "marketplace-${env}-devhub":
            args => '-Q devhub,images --settings=settings_local_mkt';

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
