# corresponds to infra's nrpe_plugins class
class base::nrpe_plugins {
  include nrpe::plugins
  realize(
    Nrpe::Plugin['check_puppet', 'puppet_update', 'uptime', 'check_ro_mounts'])
}
