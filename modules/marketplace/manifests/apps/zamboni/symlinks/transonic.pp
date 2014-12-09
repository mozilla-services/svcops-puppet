# manages transonic media symlink
define marketplace::apps::zamboni::symlinks::transonic(
  $transonic_dir
) {
  $zamboni_media = "${name}/media"

  file {
    "${zamboni_media}/transonic":
      ensure => link,
      target => "${transonic_dir}/transonic/src/media"
  }
}
