# darjeeling admin class
class marketplace::apps::darjeeling::admin(
  $instances = {}
) {
  create_resources(marketplace::apps::darjeeling::admin_instance, $instances)
}
