# admin instance class
class marketplace::apps::monolith::admin(
    $instances = {},
) {
    create_resources(marketplace::apps::monolith::admin_instance, $instances)
}
