# celery instance class
class marketplace::apps::addon_registration::celery(
    $instances = {},
) {
    create_resources(marketplace::apps::addon_registration::celery_instance, $instances)
}
