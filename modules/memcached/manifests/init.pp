# memcached class
class memcached (
    $version = 'present',
    $max_connections = '10024',
    $port = '11211'
) {

    $cachesize = inline_template('<%= @memorysize =~ /^(\d+)/; val = ( ( $1.to_i * 1024) / 1.05 ).to_i %>m')

    package {
        'memcached':
            ensure => $version;
    }

    package {
        'perl-Cache-Memcached':
            ensure => present;
    }

    service {
        'memcached':
            ensure  => running,
            enable  => true,
            require => Package[memcached];
    }

    file {
        '/etc/sysconfig/memcached':
            ensure  => present,
            content => template('memcached/memcached'),
            require => Package[memcached];
    }
}
