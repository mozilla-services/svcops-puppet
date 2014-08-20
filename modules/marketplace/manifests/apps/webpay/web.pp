# web instance class
class marketplace::apps::webpay::web(
  $instances = {}
) {
  create_resources(marketplace::apps::webpay::web_instance, $instances)
}
