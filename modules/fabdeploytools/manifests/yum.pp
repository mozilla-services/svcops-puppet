# fabdeploytools::yum
class fabdeploytools::yum(
    $package_server
) {
    yumrepo { 'deploytools':
        baseurl        => $package_server,
        descr          => 'Deploytools Repo',
        enabled        => 1,
        priority       => 2,
        gpgcheck       => 0,
        failovermethod => priority,
    }
}
