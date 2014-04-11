# nginx redirect class
class marketplace::nginx::redirect(
  $instances = {}
) {
  create_resources(marketplace::nginx::redirect_instance, $instances)
}
