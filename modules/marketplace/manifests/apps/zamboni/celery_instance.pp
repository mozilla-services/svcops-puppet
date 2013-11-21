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
        "addons-${env}":;

        "addons-${env}-devhub":
            args => '-Q devhub,images --maxtasksperchild=50';

        "addons-${env}-priority":
            args => '-Q priority,bulk';

        "marketplace-${env}":
            args => '-Q celery --settings=settings_local_mkt';

        "marketplace-${env}-priority":
            args => '-Q priority,bulk --settings=settings_local_mkt';

        "marketplace-${env}-devhub":
            args => '-Q devhub,images --settings=settings_local_mkt';

    }

    ganglia::plugins::gmetric::rabbitmq{
        "marketplace_${env}":
            queues => '-q celery -q images -q devhub -q bulk';

        "addons_${env}":
            queues => '-q celery -q images -q devhub -q bulk';
    }

    rabbitmq_user {
        "marketplace_${env}":
            admin    => false,
            password => $marketplace_password,
            provider => 'rabbitmqctl';
        "addons_${env}":
            admin    => false,
            password => $addons_password,
            provider => 'rabbitmqctl';
    }

    rabbitmq_vhost {
        [
            "marketplace_${env}",
            "addons_${env}"
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
        "addons_${env}@addons_${env}":
            configure_permission => '.*',
            read_permission      => '.*',
            write_permission     => '.*',
            provider             => 'rabbitmqctl';
    }
}
