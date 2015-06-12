# admin instance class
class marketplace::apps::marketplace_submission::admin(
  $instances = {},
) {
  create_resources(marketplace::apps::marketplace_submission::admin_instance, $instances)
}
