# Bug 775335
class base::nscd {
    if $::osfamily == "RedHat" {
        service {
            'nscd':
                ensure => stopped,
                enable => false
        }
    }
}
