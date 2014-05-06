# admin instance class
class marketplace::apps::yogafire::admin(
  $instances = {},
) {
  create_resources(marketplace::apps::yogafire::admin_instance, $instances)
}
