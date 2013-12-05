# marketplace flightdeck web class.
class marketplace::apps::flightdeck::web(
    $instances = {}
) {
    create_resources(marketplace::apps::flightdeck::web_instance, $instances)
}
