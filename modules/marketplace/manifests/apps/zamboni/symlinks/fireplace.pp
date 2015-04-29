# manages fireplace media symlink
define marketplace::apps::zamboni::symlinks::fireplace(
  $fireplace_dir,

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

      "zamboni::symlinks::fireplace::${name}::media::fireplace":
        ensure   => 'link',
        filename =>  'media/fireplace',
        target   => "${fireplace_dir}/fireplace/src/media";
    }
  }
}
