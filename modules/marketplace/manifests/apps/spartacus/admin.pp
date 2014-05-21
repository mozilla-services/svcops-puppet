# admin instance class
class marketplace::apps::spartacus::admin(
  $instances = {},
) {
  create_resources(marketplace::apps::spartacus::admin_instance, $instances)
}
