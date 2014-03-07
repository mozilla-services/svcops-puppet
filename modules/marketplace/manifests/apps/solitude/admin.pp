# solitude admin class
class marketplace::apps::solitude::admin(
  $instances = {}
) {
  create_resources(marketplace::apps::solitude::admin_instance, $instances)
}
