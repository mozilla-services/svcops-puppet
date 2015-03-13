# manages marketplace_stats media symlink
define marketplace::apps::zamboni::symlinks::marketplace_stats(
  $marketplace_stats_dir,
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
      "zamboni::symlinks::marketplace_stats::${name}::media::marketplace_stats":
        ensure   => 'link',
        filename =>  'media/marketplace_stats',
        target   => "${marketplace_stats_dir}/marketplace_stats/src/media";
    }
  }

  file {
    "${zamboni_media}/marketplace_stats":
      ensure => link,
      target => "${marketplace_stats_dir}/marketplace_stats/src/media"
  }
}
