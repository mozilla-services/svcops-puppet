# admin instance class
class marketplace::apps::marketplace_stats::admin(
  $instances = {},
) {
  create_resources(marketplace::apps::marketplace_stats::admin_instance, $instances)
}
