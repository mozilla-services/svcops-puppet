# geodude web class
class marketplace::apps::geodude::web(
  $instances = {}
) {
  create_resources(marketplace::apps::geodude::web_instance, $instances)
}
