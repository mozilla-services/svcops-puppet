# celery instance class
class marketplace::apps::olympia::celery(
  $instances = {},
) {
  create_resources(marketplace::apps::olympia::celery_instance, $instances)
}
