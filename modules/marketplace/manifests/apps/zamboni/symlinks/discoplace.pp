# manages discoplace media symlink
define marketplace::apps::zamboni::symlinks::discoplace(
  $discoplace_dir
) {
  $zamboni_media = "${name}/media"

  file {
    "${zamboni_media}/discoplace":
      ensure => link,
      target => "${discoplace_dir}/discoplace/src/media"
  }
}
