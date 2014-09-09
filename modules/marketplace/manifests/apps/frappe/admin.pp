# admin instance class
class marketplace::apps::frappe::admin(
  $instances = {},
) {
  create_resources(marketplace::apps::frappe::admin_instance, $instances)
}
