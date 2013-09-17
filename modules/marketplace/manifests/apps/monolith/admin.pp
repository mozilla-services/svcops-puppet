class marketplace::apps::monolith::admin(
    $web_settings = {},
    $aggregator_settings = {}
) {
   create_resources(marketplace::apps::monolith::settings::web, $web_settings) 

   create_resources(marketplace::apps::monolith::settings::aggregator, $aggregator_settings)
}
