# admin instance class
class marketplace::apps::discoplace::admin(
  $instances = {},
) {
  create_resources(marketplace::apps::discoplace::admin_instance, $instances)
}
