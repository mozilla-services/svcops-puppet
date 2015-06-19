# manages marketplace_submission media symlink
define marketplace::apps::zamboni::symlinks::marketplace_submission(
  $marketplace_submission_dir,
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
      "zamboni::symlinks::marketplace-submission::${name}::media::marketplace-submission":
        ensure   => 'link',
        filename =>  'media/submission',
        target   => "${marketplace_submission_dir}/marketplace-submission/src/media";
    }
  }
}
