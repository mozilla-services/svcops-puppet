# admin instance class
class marketplace::apps::marketplace_operator_dashboard::admin(
  $instances = {},
) {
  create_resources(marketplace::apps::marketplace_operator_dashboard::admin_instance, $instances)
}
