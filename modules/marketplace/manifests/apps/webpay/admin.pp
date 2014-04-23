# admin instance class
class marketplace::apps::webpay::admin(
  $instances = {}
) {
  create_resources(marketplace::apps::webpay::admin_instance, $instances)
}
