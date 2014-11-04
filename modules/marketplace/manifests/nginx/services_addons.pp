# nginx services_addons class
class marketplace::nginx::services_addons(
  $instances = {}
) {
  create_resources(marketplace::nginx::services_addons_instance, $instances)
}
