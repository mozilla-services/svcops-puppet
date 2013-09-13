# aggregator settings.
define marketplace::apps::monolith::settings::aggregator(
    $mkt_endpoint,
    $db_uri,
    $es_url,
    $ga_auth,
    $mkt_user,
    $mkt_pass
) {
    $location = $name
    file {
        "${location}/aggregator.ini":
            content => template('marketplace/apps/monolith/settings/aggregator.ini');
        "${location}/auth.json":
            content => $ga_auth;
        "${location}/monolith.password.ini":
            content => template('marketplace/apps/monolith/settings/monolith.password.ini');
    }
}
