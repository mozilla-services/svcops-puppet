# admin instance class
class marketplace::apps::frappe::admin(
  $instances = {},
) {

  package {
    'atlas':
      ensure => 'installed';
    'atlas-devel':
      ensure => 'installed';
  }

  create_resources(marketplace::apps::frappe::admin_instance, $instances)
}
