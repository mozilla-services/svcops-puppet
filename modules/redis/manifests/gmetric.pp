# set up gmetric for redis.
define redis::gmetric($port)
{
    include redis

    $redis_name = $name
    cron {
        "gmetric_${redis_name}":
            command => "/usr/local/bin/redis_ganglia.py ${redis_name} ${port}",
            require => File['/usr/local/bin/redis_ganglia.py'],
            user    => root;
    }
}
