# memcached multi class
class memcached::multi (
  $cachesize,
  $instances = {},
) {

  class {
    'memcached::limits':
      cachesize => $cachesize;
  }

  create_resources(
    memcached::multi_instance,
    $instances,
    {'cachesize' => $cachesize}
  )
}
