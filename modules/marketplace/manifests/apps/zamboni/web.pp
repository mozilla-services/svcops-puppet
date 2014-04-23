# marketplace web class.
class marketplace::apps::zamboni::web(
  $instances = {}
) {
  create_resources(marketplace::apps::zamboni, $instances)
}
