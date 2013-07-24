# name is something like mkt.prod/marketplace.firefox.com
define fabdeploytools::package(
    $host_root,
    $environ, # something like, prod, dev, stage
    $app_name,
    $version = 'LATEST'
) {
    $cluster_domain = $name

    exec {
        $cluster_domain:
            command => "/bin/rpm -i ${host_root}/${cluster_domain}/${version}",
            unless  => "/bin/rpm -q deploy-${app_name}-${environ}";
    }
}
