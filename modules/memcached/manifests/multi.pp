# memcached multi class
class memcached::multi (
  $cachesize,
  $instances = {},
) {

  class {
    'memcache::limits':
      cachesize => $cachesize;
  }

  create_resources(
    memcached::multi_instance,
    $instances,
    {'cachesize' => $cachesize}
  )
}
