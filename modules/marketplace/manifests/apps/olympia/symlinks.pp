# manages webroot symlinks
define marketplace::apps::olympia::symlinks(
  $netapp,

  $cluster = undef,
  $env = undef,
) {
  $olympia_webroot = "${name}/default/webroot"
  $olympia_overlay_root = 'default/webroot'

  if $cluster and $env {
    Marketplace::Overlay {
      app     => 'olympia',
      cluster => $cluster,
      env     => $env,
    }

    marketplace::overlay {
      "olympia::symlinks::${name}::olympia":
        ensure   => 'directory',
        filename => 'default';

      "olympia::symlinks::${name}::olympia::webroot":
        ensure   => 'directory',
        filename => 'default/webroot';

      "olympia::symlinks::${name}::olympia::webroot::media":
        ensure   => 'link',
        filename => "${olympia_overlay_root}/media",
        target   => '../../media';

      "olympia::symlinks::${name}::olympia::webroot::static":
        ensure   => 'link',
        filename => "${olympia_overlay_root}/static",
        target   => '../../site-static';

      "olympia::symlinks::${name}::olympia::webroot::user-media":
        ensure   => 'link',
        filename => "${olympia_overlay_root}/user-media",
        target   => "${netapp}/shared_storage/uploads";

      "olympia::symlinks::${name}::olympia::webroot::favicon":
        ensure   => 'link',
        filename => "${olympia_overlay_root}/favicon.ico",
        target   => '../../site-static/img/favicon.ico';

      "olympia::symlinks::${name}::olympia::webroot::storage":
        ensure   => 'directory',
        filename => "${olympia_overlay_root}/storage";

      "olympia::symlinks::${name}::olympia::webroot::storage::shared_storage":
        ensure   => 'directory',
        filename => "${olympia_overlay_root}/storage/shared_storage";

      "olympia::symlinks::${name}::olympia::webroot::storage::files":
        ensure   => 'link',
        filename => "${olympia_overlay_root}/storage/files",
        target   => "${netapp}/files";

      "olympia::symlinks::${name}::olympia::webroot::storage::shared_storage::uploads":
        ensure   => 'link',
        filename => "${olympia_overlay_root}/storage/shared_storage/uploads",
        target   => "${netapp}/shared_storage/uploads";

      "olympia::symlinks::${name}::olympia::webroot::storage::shared_storage::ryf":
        ensure   => 'link',
        filename => "${olympia_overlay_root}/storage/shared_storage/ryf",
        target   => "${netapp}/shared_storage/ryf";

      "olympia::symlinks::${name}::olympia::webroot::storage::public-staging":
        ensure   => 'link',
        filename => "${olympia_overlay_root}/storage/public-staging",
        target   => "${netapp}/public-staging";
    }
  }
  file {
    "${olympia_webroot}/media":
      ensure => 'link',
      target => '../../media';

    "${olympia_webroot}/static":
      ensure => 'link',
      target => '../../site-static';

    "${olympia_webroot}/user-media":
      ensure => 'link',
      target => "${netapp}/shared_storage/uploads";

    "${olympia_webroot}/favicon.ico":
      ensure => 'link',
      target => '../../site-static/img/favicon.ico';

    "${olympia_webroot}/storage":
      ensure => 'directory';

    "${olympia_webroot}/storage/shared_storage":
      ensure => 'directory';

    "${olympia_webroot}/storage/files":
      ensure => 'link',
      target => "${netapp}/files";

    "${olympia_webroot}/storage/public-staging":
      ensure => 'link',
      target => "${netapp}/public-staging";

    "${olympia_webroot}/storage/shared_storage/ryf":
      ensure => 'link',
      target => "${netapp}/shared_storage/ryf";

    "${olympia_webroot}/storage/shared_storage/uploads":
      ensure => 'link',
      target => "${netapp}/shared_storage/uploads";
  }
}
