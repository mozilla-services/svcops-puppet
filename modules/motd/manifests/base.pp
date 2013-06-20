# motd base
class motd::base {
    include concat::setup

    concat {
        '/etc/motd':
            owner => root,
            group => root,
            mode  => '0644';
    }
}
