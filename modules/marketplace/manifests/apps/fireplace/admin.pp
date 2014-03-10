# admin instance class
class marketplace::apps::fireplace::admin(
  $instances = {},
) {
  create_resources(marketplace::apps::fireplace::admin_instance, $instances)
}
