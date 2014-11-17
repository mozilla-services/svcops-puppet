# manages marketplace_operator_dashboard media symlink
define marketplace::apps::zamboni::symlinks::marketplace_operator_dashboard(
  $marketplace_operator_dashboard_dir
) {
  $zamboni_media = "${name}/media"

  file {
    "${zamboni_media}/marketplace-operator-dashboard":
      ensure => 'link',
      target => "${marketplace_operator_dashboard_dir}/marketplace-operator-dashboard/src/media",
  }
}
