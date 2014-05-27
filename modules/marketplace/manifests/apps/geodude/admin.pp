# admin instance class
class marketplace::apps::geodude::admin(
  $instances = {},
) {
  create_resources(marketplace::apps::geodude::admin_instance, $instances)
}
