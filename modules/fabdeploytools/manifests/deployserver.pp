# fabdeploytools
class fabdeploytools::deployserver(
    $root = '/var/deployserver',
    $server_name = 'deployserver',
    $webserver = 'nginx', # can be nginx or httpd
    $access = '' # this would be some webserver specific access statement.
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
