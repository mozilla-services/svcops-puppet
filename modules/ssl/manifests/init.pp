#ssl instance class
class ssl (
    $ssl_dir = '/etc/pki',
    $resources = {}
) {
    file {
        $ssl_dir:
            ensure => directory,
            mode   => '0755',
            owner  => 'root',
            group  => 'root'
    }
    create_resources(ssl::resource, $resources)
}
