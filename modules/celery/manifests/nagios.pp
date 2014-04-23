class celery::nagios {

  package {
    'python-amqplib':
      ensure => latest
  }

  file {
    "/usr/${::archlib}/nagios/plugins/custom/rabbitmq_queue_check.py":
      source => "puppet:///modules/${module_name}/rabbitmq_queue_check.py",
      mode   => '0755';
    '/etc/nagios/nrpe.d/rabbitmq_queue_check.cfg':
      notify  => Service['nrpe'],
      content => template("${module_name}/rabbitmq_queue_check.cfg.erb");
  }
}
