# web instance class
class marketplace::apps::zippy::web(
  $instances = {},
) {
  create_resources(marketplace::apps::zippy::web_instance, $instances)
}
