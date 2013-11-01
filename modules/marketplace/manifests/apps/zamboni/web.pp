# marketplace web class.
class marketplace::apps::monolith::zamboni::web(
    $instances = {}
) {
    create_resources(marketplace::apps::zamboni, $instances)
}
