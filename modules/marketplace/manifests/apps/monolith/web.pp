class marketplace::apps::monolith::web(
    $nginx = {},
    $instances = {}
) {

    include nginx
    create_resources(marketplace::apps::monolith, $instances)
    create_resources(marketplace::nginx::monolith, $nginx)

}
