define marketplace::apps::monolith::settings::web(
    $es_url,
    $statsd_host
) {
    $project_dir = $name
    file {
        "${project_dir}/monolith/monolith.ini":
            content => template('marketplace/apps/monolith/settings/web.ini');
    }
}
