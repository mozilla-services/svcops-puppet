# manages marketplace_content_tools media symlink
define marketplace::apps::zamboni::symlinks::marketplace_content_tools(
  $marketplace_content_tools_dir,
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
      "zamboni::symlinks::marketplace-content-tools::${name}::media::marketplace-content-tools":
        ensure   => 'link',
        filename =>  'media/marketplace-content-tools',
        target   => "${marketplace_content_tools_dir}/marketplace-content-tools/src/media";
    }
  }
}
