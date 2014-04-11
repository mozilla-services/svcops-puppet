# redirect domains to specific url
define marketplace::nginx::redirect::redirect_instance(
  $redirect_names, # ['builder.addons.mozilla.org']
  $redirect_url = 'http://www.example.com/',
  $template_file = 'marketplace/nginx/redirect.conf',
) {
  $config_name = $name

  nginx::config {
    $config_name:
      content => template($template_file);
  }

  nginx::logdir {
    $config_name:;
  }
}
