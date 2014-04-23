# add an apache config
define apache::config(
  $content
) {
  include apache
  $conf_name = $name
  file {
    "${apache::root}/${conf_name}.conf":
      notify  => Service['httpd'],
      content => $content;
  }
}
