# name is something like mkt.prod/marketplace.firefox.com
define fabdeploytools::s3package(
    $bucket,
    $app_name,
    $environ, # something like, prod, dev, stage
    $version = 'LATEST'
) {
    $cluster_domain = $name

    exec {
        $cluster_domain:
            command => "/usr/bin/fetch_file s3://${bucket}/packages/${cluster_domain}/${version} | /bin/rpm -i -",
            unless  => "/bin/rpm -q deploy-${app_name}-${environ}";
    }

}
