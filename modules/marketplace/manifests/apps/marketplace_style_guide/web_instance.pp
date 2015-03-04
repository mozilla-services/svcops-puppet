# define marketplace_style_guide instance.
define marketplace::apps::marketplace_style_guide::web_instance(
  $project_dir,
  $nginx_port = '81',
) {

  $config_name = $name

  nginx::config {
    $config_name:
      content => template('marketplace/apps/marketplace_style_guide/web/nginx.conf');
  }

  nginx::logdir {
    $config_name:;
  }
}
