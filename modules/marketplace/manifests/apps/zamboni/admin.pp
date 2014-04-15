# marketplace admin class.
class marketplace::apps::zamboni::admin(
  $instances = {}
) {
  contain marketplace::apps::zamboni::packages

  create_resources(marketplace::apps::zamboni::admin_instance, $instances)
}
