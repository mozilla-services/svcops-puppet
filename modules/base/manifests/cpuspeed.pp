# disable cpuspeed
class base::cpuspeed {
  if ($::osfamily == "RedHat") and ($::virtual != 'xen') {
    service {
      'cpuspeed':
        ensure    => stopped,
        enable    => false
    }
  }
}
