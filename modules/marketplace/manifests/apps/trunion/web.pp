# marketplace trunion web class.
class marketplace::apps::trunion::web(
  $instances = {}
) {
  create_resources(marketplace::apps::trunion::web_instance, $instances)
}
