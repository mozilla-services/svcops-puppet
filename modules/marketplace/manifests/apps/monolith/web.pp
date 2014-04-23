# marketplace web class.
class marketplace::apps::monolith::web(
  $instances = {}
) {
  create_resources(marketplace::apps::monolith::web_instance, $instances)
}
