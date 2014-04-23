# nfsclient instance class
class nfsclient::mounts(
  $instances = {}
) {
  create_resources(nfsclient::mount, $instances)
}
