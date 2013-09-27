# add a cluster to the admin server
define pushgo::admin_cluster(
    $s3_bucket,
    $environ,
    $servername,
    $stack_name,
    $elb,
    $route53_record,
    $route53_zone,
    $region = $::ec2_region
) {
    $cluster = $name
    $cluster_src = "/data/${cluster}/src"
    git::clone {
        "${cluster_src}/push.mozilla.com/pushgo":
            repo => 'https://github.com/mozilla-services/pushgo.git';
    }

    file {
        "${cluster_src}/push.mozilla.com/fabfile.py":
            require => Git::Clone["${cluster_src}/push.mozilla.com/pushgo"],
            content => template('pushgo/admin/fabfile.py');
    }

    fabdeploytools::deploytools::env {
        "pushgo.${environ}":
            hostcontent => "{\"web\": \"aws:tag:aws:cloudformation:stack-name=${stack_name}\"}";
    }

    cron {
        "pushgo-admin-supervise-${cluster}":
            command => "/usr/bin/pushgo-supervise -r ${region} --elb ${elb} --rr ${route53_record} --zone ${route53_zone}";
        "pushgo-admin-cloudwatch-${cluster}":
            command => "/usr/bin/pushgo-cloudwatch-metrics -r \"${region}\" -s \"${stack_name}\" -e \"${environ}\"";
    }
}
