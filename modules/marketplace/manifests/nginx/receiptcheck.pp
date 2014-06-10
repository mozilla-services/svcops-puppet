# nginx receiptcheck class
class marketplace::nginx::receiptcheck(
  $instances = {}
) {
  create_resources(marketplace::nginx::receiptcheck_instance, $instances)
}
