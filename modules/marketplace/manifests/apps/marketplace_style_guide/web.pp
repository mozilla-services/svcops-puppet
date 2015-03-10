# web instance class
class marketplace::apps::marketplace_style_guide::web(
  $instances = {},
) {

  create_resources(marketplace::apps::marketplace_style_guide::web_instance, $instances)
}
