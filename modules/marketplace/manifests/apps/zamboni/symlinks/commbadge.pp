# manages commbadge media symlink
define marketplace::apps::zamboni::symlinks::commbadge(
  $commbadge_dir,
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
      "zamboni::symlinks::commbadge::${name}::media::commbadge":
        ensure   => 'link',
        filename =>  'media/commbadge',
        target   => "${commbadge_dir}/commbadge/src/media";
    }
  }

  file {
    "${zamboni_media}/commbadge":
      ensure => link,
      target => "${commbadge_dir}/commbadge/src/media"
  }
}
