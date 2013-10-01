# aggregator settings.
define marketplace::apps::monolith::settings::aggregator(
    $mkt_endpoint,
    $db_uri,
    $es_url,
    $ga_auth,
    $mkt_user,
    $mkt_pass,
    $cron_user = 'mkt_prod_monolith'
) {
    $location = $name
    cron {
        "aggr-${location}":
            environment => 'MAILTO=amo-developers@mozilla.org',
            command     => "cd ${location}/monolith-aggregator; ../venv/bin/monolith-extract aggregator.ini --date yesterday",
            user        => $cron_user,
            hour        => 1,
            minute      => 15;
    }

    file {
        "${location}/monolith-aggregator/aggregator.ini":
            content => template('marketplace/apps/monolith/settings/aggregator.ini');

        "${location}/monolith-aggregator/auth.json":
            content => $ga_auth;

        "${location}/monolith-aggregator/monolith.password.ini":
            content => template('marketplace/apps/monolith/settings/monolith.password.ini');
    }
}
