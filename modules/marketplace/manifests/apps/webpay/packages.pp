# marketplace packages
class marketplace::apps::webpay::packages {
  include marketplace::virtual_packages
  realize Package[
    'python-pylibmc',
    'python27-python-pylibmc'
  ]
}
