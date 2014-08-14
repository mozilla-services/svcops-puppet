# web instance class
class marketplace::apps::testmanifest::web(
  $instances = {},
) {
  create_resources(marketplace::apps::testmanifest::web_instance, $instances)
}
