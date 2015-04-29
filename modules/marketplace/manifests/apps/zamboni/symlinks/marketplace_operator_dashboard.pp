# manages marketplace_operator_dashboard media symlink
define marketplace::apps::zamboni::symlinks::marketplace_operator_dashboard(
  $marketplace_operator_dashboard_dir,
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
      "zamboni::symlinks::marketplace-operator-dashboard::${name}::media::marketplace-operator-dashboard":
        ensure   => 'link',
        filename =>  'media/marketplace-operator-dashboard',
        target   => "${marketplace_operator_dashboard_dir}/marketplace-operator-dashboard/src/media";
    }
  }
}
