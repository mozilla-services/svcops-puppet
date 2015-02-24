# admin instance class
class marketplace::apps::spartacus::admin(
  $instances = {},
) {
  include marketplace::virtual_packages
  realize Package[
    'firefox'
  ]

  create_resources(marketplace::apps::spartacus::admin_instance, $instances)
}
