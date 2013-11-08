# admin instance class
class marketplace::apps::addon_registration::admin(
    $instances = {},
) {
    create_resources(marketplace::apps::addon_registration::admin_instance, $instances)
}
