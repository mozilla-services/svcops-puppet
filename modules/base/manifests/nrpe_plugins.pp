# corresponds to infra's nrpe_plugins class
class base::nrpe_plugins ($plugins = []) {
  include nrpe::plugins
  # base plugins
  realize(
    Nrpe::Plugin[
                'check_puppet',
                'puppet_update',
                'uptime',
                'check_ro_mounts',
                'auditd'
                ])
  # additional plugins via hiera
  realize(Nrpe::Plugin[$plugins])
}
