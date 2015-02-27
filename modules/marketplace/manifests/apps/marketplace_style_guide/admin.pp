# admin instance class
class marketplace::apps::marketplace_style_guide::admin(
  $instances = {},
) {
  create_resources(marketplace::apps::marketplace_style_guide::admin_instance, $instances)
}
