# define a flower instance
# rabbitmq management plugin must be enabled for broker_api
define flower::instance(
    $broker_url, # amqp://username:password@rabbitmq-hostname:5672/vhost
    $broker_api, # http://username:password@rabbitmq-hostname:15672/api
    $domain = '', # flower.example.com
    $port = '50000',
    $webserver = 'nginx' # set this to either nginx or httpd
){
    include flower::packages
    $instance = "flower-${name}"

    # supervise the service
    supervisord::service {
        $instance:
            command => "/usr/bin/flower --port=${port} --broker=${broker_url} --broker_api=${broker_api}",
            app_dir => '/tmp',
            user    => 'nobody',
            require => Class[flower::packages];
    }

    # add nginx configs to host
    if $webserver == 'nginx' {
        $upstream = "flower_${name}"
        nginx::upstream {
            $upstream:
                upstream_port => $port,
                require       =>  Supervisord::Service[$instance];
        }
        nginx::serverproxy {
            $domain:
                proxyto  => "http://${upstream}";
        }
    }
    elsif $webserver == 'httpd' {
        apache::config {
            $domain:
                content => template('flower/flower.httpd.conf');
        }
    }
}
