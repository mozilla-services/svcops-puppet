# fabdeploytools::yum
class fabdeploytools::yum(
    $package_server
) {
    yumrepo { 'deploytools':
        baseurl         => $package_server,
        descr           => 'Deploytools Repo',
        enabled         => 1,
        metadata_expire => '30',
        priority        => 1,
        gpgcheck        => 0,
        failovermethod  => priority,
    }
}
