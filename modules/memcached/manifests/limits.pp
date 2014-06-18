# memcached limits
class memcached::limits(
  $cachesize = undef
){

  $memlock_size = ($cachesize + 64) * 1024

  $limits_config =  {
    'memcached-soft' => {
      'domain'       => 'nobody',
      'type'         => 'soft',
      'item'         => 'memlock',
      'size'         => $memlock_size
    },
    'memcached-hard' => {
      'domain'       => 'nobody',
      'type'         => 'hard',
      'item'         => 'memlock',
      'size'         => $memlock_size
    },
  }

  limits {
    'memcached':
      config => $limits_config,
  }
}
