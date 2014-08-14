# admin instance class
class marketplace::apps::testmanifest::admin(
  $instances = {},
) {
  create_resources(marketplace::apps::testmanifest::admin_instance, $instances)
}
