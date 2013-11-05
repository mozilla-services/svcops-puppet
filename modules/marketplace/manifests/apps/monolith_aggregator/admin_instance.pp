# define admin instance for monolith aggregator
define marketplace::apps::monolith_aggregator::admin_instance(
    $mkt_endpoint,
    $mkt_transaction_endpoint,
    $db_uri,
    $es_url,
    $es_index_prefix,
    $ga_auth,
    $mkt_user,
    $mkt_pass,
    $solitude_access_key,
    $solitude_secret_key,
    $solitude_bucket,
    $cluster,
    $domain,
    $env,
    $ssh_key,
    $dreadnot_name,
    $dreadnot_instance,
    $log_level = 'debug',
    $es_index_prefix = undef,
    $cron_user = 'mkt_prod_monolith',
    $pyrepo = 'https://pyrepo.addons.mozilla.org/'
) {
    $project_dir = $name
    git::clone {
        "${project_dir}/monolith-aggregator":
            repo => 'https://github.com/mozilla/monolith-aggregator.git';

    }

    $log_file = "/var/log/${domain}.log"

    # make sure log file is owned by the cron user
    file {
        $log_file:
            ensure => present,
            owner  => $cron_user
    }

    cron {
        "aggr-${project_dir}":
            environment => 'MAILTO=amo-developers@mozilla.org',
            command     => "cd ${project_dir}/monolith-aggregator; ../venv/bin/monolith-extract aggregator.ini --log-level ${log_level} --date yesterday >(tee ${log_file}) 2> >(tee ${log_file} >&2)",
            user        => $cron_user,
            hour        => 1,
            minute      => 15;
    }

    file {
        "${project_dir}/monolith-aggregator/aggregator.ini":
            require => Git::Clone["${project_dir}/monolith-aggregator"],
            content => template('marketplace/apps/monolith_aggregator/admin/aggregator.ini');

        "${project_dir}/monolith-aggregator/auth.json":
            require => Git::Clone["${project_dir}/monolith-aggregator"],
            content => $ga_auth;

        "${project_dir}/monolith-aggregator/monolith.password.ini":
            require => Git::Clone["${project_dir}/monolith-aggregator"],
            content => template('marketplace/apps/monolith_aggregator/admin/monolith.password.ini');

        "${project_dir}/monolith-aggregator/solitude_aws_keys.ini":
            require => Git::Clone["${project_dir}/monolith-aggregator"],
            content => template('marketplace/apps/monolith_aggregator/admin/solitude_aws_keys.ini');
    }

    file {
        "${project_dir}/monolith-aggregator/deploysettings.py":
            require => Git::Clone["${project_dir}/monolith-aggregator"],
            content => template('marketplace/apps/monolith/deploysettings.py');
    }

    dreadnot::stack {
        $dreadnot_name:
            instance_name => $dreadnot_instance,
            project_dir   => "${project_dir}/monolith-aggregator",
            github_url    => 'https://github.com/mozilla/monolith-aggregator',
            git_url       => 'git://github.com/mozilla/monolith-aggregator.git';
    }
}
