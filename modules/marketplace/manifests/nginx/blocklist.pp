# nginx blocklist class
class marketplace::nginx::blocklist(
  $instances = {}
) {
  create_resources(marketplace::nginx::blocklist_instance, $instances)
}
