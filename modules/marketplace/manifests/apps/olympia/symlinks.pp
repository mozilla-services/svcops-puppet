# manages webroot symlinks
define marketplace::apps::olympia::symlinks(
  $netapp,
  $static_root,
) {
  $olympia_webroot = "${name}/default/webroot"

  file {
    "${olympia_webroot}/media":
      ensure => 'link',
      target => '../../media';

    "${olympia_webroot}/static":
      ensure => 'link',
      target => $static_root;

    "${olympia_webroot}/favicon.ico":
      ensure => 'link',
      target => "${static_root}/img/favicon.ico";

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
