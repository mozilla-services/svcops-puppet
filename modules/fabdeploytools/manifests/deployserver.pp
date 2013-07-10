# fabdeploytools
class fabdeploytools::deployserver(
    $root = '/var/deployserver',
    $server_name = 'deployserver',
    $webserver = 'nginx', # can be nginx or httpd
    $access = [], # this is a list of hashes, e.g., [{location => /prod, allow_from => '127.0.0.1'}]
    $port = '8080'
) {
    $package_root = "${root}/packages"
    file {
        $root:
            ensure => directory;

        $package_root:
            ensure => directory;
    }

    if $webserver == 'nginx' {
        nginx::config {
            $server_name:
                content => template('fabdeploytools/deployserver.nginx.conf');
        }
    } elsif $webserver == 'httpd' {
        apache::config {
            $server_name:
                content => template('fabdeploytools/deployserver.httpd.conf');
        }
    }
}
