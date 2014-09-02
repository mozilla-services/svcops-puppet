# manages webroot symlinks
define marketplace::apps::zamboni::symlinks(
  $netapp
) {
  $mkt_webroot = "${name}/mkt/webroot"

  file {
    "${mkt_webroot}/media":
      ensure => link,
      target => '../../media';

    "${mkt_webroot}/favicon.ico":
      ensure => link,
      target => '../../media/img/favicon.ico';

    "${mkt_webroot}/storage":
      ensure => directory;

    "${mkt_webroot}/storage/shared_storage":
      ensure => directory;

    "${mkt_webroot}/storage/files":
      ensure => link,
      target => "${netapp}/files";

    "${mkt_webroot}/storage/shared_storage/uploads":
      ensure => link,
      target => "${netapp}/shared_storage/uploads";

    "${mkt_webroot}/storage/shared_storage/public_keys":
      ensure => link,
      target => "${netapp}/shared_storage/public_keys";

    "${mkt_webroot}/storage/shared_storage/inapp-image":
      ensure => link,
      target => "${netapp}/shared_storage/inapp-image";

    "${mkt_webroot}/storage/shared_storage/product-icons":
      ensure => link,
      target => "${netapp}/shared_storage/product-icons";

    "${mkt_webroot}/storage/shared_storage/dumped-apps":
      ensure => directory;

    "${mkt_webroot}/storage/shared_storage/dumped-apps/tarballs":
      ensure => link,
      target => "${netapp}/shared_storage/dumped-apps/tarballs";
  }
}
