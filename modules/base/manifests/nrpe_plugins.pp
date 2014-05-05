# corresponds to infra's nrpe_plugins class
class base::nrpe_plugins () {
  $plugins = hiera_array('base::nrpe_plugins::plugins', [])

  include nrpe::plugins
  # base plugins
  realize(
    Nrpe::Plugin[
      'auditd',
      'check_puppet',
      'check_ro_mounts',
      'ntp_time_multi',
      'puppet_update',
      'uptime'
    ])
  # additional plugins via hiera
  realize(Nrpe::Plugin[$plugins])
}
