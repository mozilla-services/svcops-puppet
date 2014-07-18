# manages fireplace media symlink
define marketplace::apps::zamboni::symlinks::fireplace(
  $fireplace_dir
) {
  $zamboni_media = "${name}/media"

  file {
    "${zamboni_media}/fireplace":
      ensure => link,
      target => "${fireplace_dir}/fireplace/src/media"
  }
}
