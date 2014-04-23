# marketplace addon_registration web class.
class marketplace::apps::addon_registration::web(
  $instances = {}
) {
  create_resources(marketplace::apps::addon_registration::web_instance, $instances)
}
