# supervisord base class
class supervisord::base inherits supervisord::params {
    # It is no longer necessary to 'include supervisord::base'
    # to declare instances of 'supervisord::service'.
    #
    # To alter the parameters to this class, use supervisord::params:
    #
    #   class {
    #       'supervisord::params':
    #           name => 'value';
    #   }
    #
    # And then declare supervisord::service instances as usual:
    #
    #   supervisord::service {
    #       'service_name':
    #           param => value;
    #   }
    #
    # The parameters from ::params will be available here automatically.

    package {
        'supervisor':
            ensure => 'latest';
    }

    file {
        '/etc/supervisord.conf':
            source => 'puppet:///modules/supervisord/supervisord.conf',
            notify => Service['supervisord'];

        '/etc/supervisord.conf.d/':
            ensure  => directory,
            notify  => Service['supervisord'],
            recurse => true,
            purge   => true;

        '/etc/init.d/supervisord':
            mode    => '0755',
            require => Package['supervisor'],
            content => template('supervisord/supervisord-init');
    }

    service {
        'supervisord':
            ensure    => running,
            require   => Package['supervisor'],
            enable    => true,
            restart   => '/usr/bin/supervisorctl update',
            start     => '/sbin/service supervisord start',
            stop      => '/sbin/service supervisord stop',
            hasstatus => true,
            status    => '/sbin/service supervisord status';
    }
}
