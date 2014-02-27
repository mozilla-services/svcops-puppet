# olympia admin class
class marketplace::apps::olympia::admin(
  $instances = {}
) {
  create_resources(marketplace::apps::olympia::admin_instance, $instances)
}
