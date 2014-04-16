# manages darjeeling media symlink
define marketplace::apps::zamboni::symlinks::darjeeling(
  $darjeeling_dir
) {
  $zamboni_media = "${name}/media"

  file {"${zamboni_media}/darjeeling":
    ensure => 'link',
    target => "${darjeeling_dir}/darjeeling/src/lite",
  }
}
