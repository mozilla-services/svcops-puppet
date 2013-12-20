# marketplace::apps::webpay::celery_instance
define marketplace::apps::webpay::celery_instance(
    $app_dir = undef,
    $webpay_password = undef,
    $env = 'prod',
    $workers = '12',
    $scl = undef,
    $user = $marketplace_private::mkt::any::prod::params::mkt_user
){

    include marketplace::apps::zamboni::packages

    $webpay_dir = "${app_dir}/current/webpay"
    $webpay_python = "${app_dir}/current/venv/bin/python"
    $environ = 'SPIDERMONKEY_INSTALLATION=/usr/bin/tracemonkey'

    Celery::Service {
        app_dir => $webpay_dir,
        python  => $webpay_python,
        workers => $workers,
        user    => $user,
        environ => $environ,
        scl     => $scl,
    }

    celery::service {
        "webpay-${env}":;
    }

    rabbitmq_user {
        "webpay_${env}":
            admin    => false,
            password => $webpay_password,
            provider => 'rabbitmqctl';
    }

    rabbitmq_vhost {
        "webpay_${env}":
            ensure   => present,
            provider => 'rabbitmqctl';
    }

    rabbitmq_user_permissions {
        "webpay_${env}@webpay_${env}":
            configure_permission => '.*',
            read_permission      => '.*',
            write_permission     => '.*',
            provider             => 'rabbitmqctl';
    }
}
