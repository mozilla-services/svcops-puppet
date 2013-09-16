class marketplace::apps::monolith::web(
    $nginx = {},
    $instances = {}
) {

    create_resource(marketplace::apps::monolith, $instances)

}
