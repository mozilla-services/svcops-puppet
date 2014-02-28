# olympia web class
class marketplace::apps::olympia::web(
  $instances = {}
) {
  create_resources(marketplace::apps::olympia::web_instance, $instances)
}
