# manages transonic media symlink
define marketplace::apps::zamboni::symlinks::transonic(
  $transonic_dir,
  $cluster = undef,
  $env = undef,
) {
  $zamboni_media = "${name}/media"

  if $cluster and $env {
    Marketplace::Overlay {
      app     => 'zamboni',
      cluster => $cluster,
      env     => $env,
    }

    marketplace::overlay {
      "zamboni::symlinks::transonic::${name}::media::transonic":
        ensure   => 'link',
        filename =>  'media/transonic',
        target   => "${transonic_dir}/transonic/src/media";
    }
  }

  file {
    "${zamboni_media}/transonic":
      ensure => link,
      target => "${transonic_dir}/transonic/src/media"
  }
}
