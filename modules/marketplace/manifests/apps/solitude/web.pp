# solitude web class
class marketplace::apps::solitude::web(
  $instances = {}
) {
  include marketplace::apps::solitude::packages
  create_resources(marketplace::apps::solitude::web_instance, $instances)
}
