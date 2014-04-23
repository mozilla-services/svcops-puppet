# celery instance class
class marketplace::apps::zamboni::celery(
  $instances = {},
) {
  create_resources(marketplace::apps::zamboni::celery_instance, $instances)
}
