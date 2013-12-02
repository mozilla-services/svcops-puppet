# admin instance class
class marketplace::apps::trunion::admin(
    $instances = {},
) {
    create_resources(marketplace::apps::trunion::admin_instance, $instances)
}
