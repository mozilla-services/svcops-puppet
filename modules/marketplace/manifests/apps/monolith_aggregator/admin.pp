# admin instance class
class marketplace::apps::monolith_aggregator::admin(
  $instances = {},
) {
  create_resources(marketplace::apps::monolith_aggregator::admin_instance, $instances)
}
