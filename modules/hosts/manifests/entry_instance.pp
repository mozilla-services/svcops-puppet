# define hosts entry instance
define hosts::entry_instance(
  $ip,
  $ensure = 'present',
  $host_aliases = undef,
) {
  $host = $name

  host {
    $host:
      ensure       => $ensure,
      host_aliases => $host_aliases,
      ip           => $ip,
  }
}
