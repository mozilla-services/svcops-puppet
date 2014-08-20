# admin instance class
class marketplace::apps::zippy::admin(
  $instances = {},
) {
  create_resources(marketplace::apps::zippy::admin_instance, $instances)
}
