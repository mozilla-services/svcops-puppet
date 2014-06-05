# admin instance class
class marketplace::apps::transonic::admin(
  $instances = {},
) {
  create_resources(marketplace::apps::transonic::admin_instance, $instances)
}
