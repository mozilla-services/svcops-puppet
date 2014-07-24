# includes repos needed in AWS.
class base::yum::aws {
  include base::yum::conf
  yumrepo {
    'mozilla-services-aws':
      baseurl  => 'https://s3.amazonaws.com/net.mozaws.prod.ops.rpmrepo/6/$basearch',
      descr    => 'services repo',
      enabled  => 1,
      priority => 5;
  }

  yumrepo { 'mozilla-services-aws-mkt':
    baseurl  => "https://s3.amazonaws.com/net.mozaws.ops.rpmrepo/${::operatingsystemmajrelease}/\$basearch/mkt",
    descr    => 'Mozilla Services AWS MKT',
    enabled  => 1,
    priority => 1,
  }
}
