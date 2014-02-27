# olympia admin class
class marketplace::apps::olympia::admin(
  $instances = {}
) {
  create_resouces(marketplace::apps::olympia::admin_instance, $instances)
}
