# marketplace::apps::addon_registration::celery_instance
define marketplace::apps::addon_registration::celery_instance(
    $app_dir,
    $registration_password,
    $user = undef,
    $env = 'prod',
    $workers = '12',
    $scl = 'python27'
){

    $addon_registration_dir = "${app_dir}/current/addon_registration"
    $addon_registration_python = "${app_dir}/current/venv/bin/python"
    $environ = "CONFIG=${addon_registration_dir}/production.ini"
    $command = "source /opt/rh/${scl}/enable; exec ${addon_registration_python} ${addon_registration_dir}/addonreg/worker.py worker"

    Celery::Service {
        command => $command,
        app_dir => $addon_registration_dir,
        user    => $user,
        environ => $environ,
    }

    celery::service {
        "registration-${env}":;
    }

    rabbitmq_user {
        "registration_${env}":
            admin    => false,
            password => $registration_password,
            provider => 'rabbitmqctl';
    }

    rabbitmq_vhost {
        [
            "registration_${env}",
        ]:
            ensure   => present,
            provider => 'rabbitmqctl';
    }

    rabbitmq_user_permissions {
        "registration_${env}@registration_${env}":
            configure_permission => '.*',
            read_permission      => '.*',
            write_permission     => '.*',
            provider             => 'rabbitmqctl';
    }
}
