# set up a vserver with a proxy.
define apache::vserverproxy(
    $proxyto
) {
    $server_name = $name
    apache::config {
        $server_name:
            content => template('apache/vserverproxy.conf');
    }
}
