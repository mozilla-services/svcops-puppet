# manages webroot symlinks
define marketplace::apps::zamboni::symlinks(
  $netapp,

  $cluster = undef,
  $env = undef,
) {
  $mkt_webroot = "${name}/mkt/webroot"
  $mkt_overlay_root = 'mkt/webroot'

  if $cluster and $env {
    Marketplace::Overlay {
      app     => 'zamboni',
      cluster => $cluster,
      env     => $env,
    }

    marketplace::overlay {
      "zamboni::symlinks::${name}::media":
        ensure   => 'directory',
        filename => 'media';

      "zamboni::symlinks::${name}::mkt":
        ensure   => 'directory',
        filename => 'mkt';

      "zamboni::symlinks::${name}::mkt::webroot":
        ensure   => 'directory',
        filename => 'mkt/webroot';

      "zamboni::symlinks::${name}::mkt::webroot::media":
        ensure   => 'link',
        filename => "${mkt_overlay_root}/media",
        target   => '../../media';

      "zamboni::symlinks::${name}::mkt::webroot::favicon":
        ensure   => 'link',
        filename => "${mkt_overlay_root}/favicon.ico",
        target   => '../../media/img/favicon.ico';

      "zamboni::symlinks::${name}::mkt::webroot::storage":
        ensure   => 'directory',
        filename => "${mkt_overlay_root}/storage";

      "zamboni::symlinks::${name}::mkt::webroot::storage::shared_storage":
        ensure   => 'directory',
        filename => "${mkt_overlay_root}/storage/shared_storage";

      "zamboni::symlinks::${name}::mkt::webroot::storage::shared_storage::dumped-apps":
        ensure   => 'directory',
        filename => "${mkt_overlay_root}/storage/shared_storage/dumped-apps";

      "zamboni::symlinks::${name}::mkt::webroot::storage::shared_storage::dumped-apps::tarballs":
        ensure   => 'link',
        filename => "${mkt_overlay_root}/storage/shared_storage/dumped-apps/tarballs",
        target   => "${netapp}/shared_storage/dumped-apps/tarballs";

      "zamboni::symlinks::${name}::mkt::webroot::storage::files":
        ensure   => 'link',
        filename => "${mkt_overlay_root}/storage/files",
        target   => "${netapp}/files";

      "zamboni::symlinks::${name}::mkt::webroot::storage::shared_storage::uploads":
        ensure   => 'link',
        filename => "${mkt_overlay_root}/storage/shared_storage/uploads",
        target   => "${netapp}/shared_storage/uploads";

      "zamboni::symlinks::${name}::mkt::webroot::storage::shared_storage::public_keys":
        ensure   => 'link',
        filename => "${mkt_overlay_root}/storage/shared_storage/public_keys",
        target   => "${netapp}/shared_storage/public_keys";

      "zamboni::symlinks::${name}::mkt::webroot::storage::shared_storage::inapp-image":
        ensure   => 'link',
        filename => "${mkt_overlay_root}/storage/shared_storage/inapp-image",
        target   => "${netapp}/shared_storage/inapp-image";

      "zamboni::symlinks::${name}::mkt::webroot::storage::shared_storage::product-icons":
        ensure   => 'link',
        filename => "${mkt_overlay_root}/storage/shared_storage/product-icons",
        target   => "${netapp}/shared_storage/product-icons";
    }
  }
}
