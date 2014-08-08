# admin instance class
class hosts::entry(
  $instances = {},
) {
  create_resources(hosts::entry_instance, $instances)
}
