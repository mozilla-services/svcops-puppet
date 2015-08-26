# admin instance class
class marketplace::apps::marketplace_content_tools::admin(
  $instances = {},
) {
  create_resources(marketplace::apps::marketplace_content_tools::admin_instance, $instances)
}
