# fabdeploytools::yum
class fabdeploytools::yum(
    $package_server,
    $env
) {
    yumrepo { 'deploytools':
        baseurl        => "http://${package_server}/${env}",
        descr          => 'Deploytools Repo',
        enabled        => 1,
        priority       => 2,
        gpgcheck       => 0,
        failovermethod => priority,
    }
}
