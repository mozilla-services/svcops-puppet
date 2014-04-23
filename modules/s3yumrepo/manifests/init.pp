#  adds an s3 yumrepo
define s3yumrepo(
  $baseurl
) {
  include s3yumrepo::plugin
  $repo_name = $name
  file {
    "/etc/yum.repos.d/s3-${repo_name}.repo":
      content => template('s3yumrepo/repo.repo');
  }
}
