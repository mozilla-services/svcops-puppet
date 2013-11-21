# celery instance class
class marketplace::apps::webpay::celery(
    $instances = {},
) {
    create_resources(marketplace::apps::webpay::celery_instance, $instances)
}
