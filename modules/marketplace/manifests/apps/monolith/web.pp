class marketplace::apps::monolith::web(
    $nginx = {},
    $instances = {}
) {

    notify { "${instances}" }
    notify { "${nginx}" }
    create_resources(marketplace::apps::monolith, $instances)
    create_resources(marketplace::nginx::monolith, $nginx)

}
