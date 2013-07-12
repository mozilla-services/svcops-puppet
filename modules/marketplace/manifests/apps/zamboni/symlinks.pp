# manages webroot symlinks
define marketplace::apps::zamboni::symlinks(
    $netapp
) {
    $zamboni_webroot = "${name}/default/webroot"

    file {
        "${zamboni_webroot}/media":
            ensure => link,
            target => '../../media';

        "${zamboni_webroot}/favicon.ico":
            ensure => link,
            target => '../../media/img/favicon.ico';

        "${zamboni_webroot}/storage":
            ensure => directory;

        "${zamboni_webroot}/storage/shared_storage":
            ensure => directory;

        "${zamboni_webroot}/storage/files":
            ensure => link,
            target => "${netapp}/files";

        "${zamboni_webroot}/storage/public-staging":
            ensure => link,
            target => "${netapp}/public-staging";

        "${zamboni_webroot}/storage/shared_storage/ryf":
            ensure => link,
            target => "${netapp}/shared_storage/ryf";

        "${zamboni_webroot}/storage/shared_storage/uploads":
            ensure => link,
            target => "${netapp}/shared_storage/uploads";
    }
}
