# includes repos needed in AWS.
class base::yum::aws {
    yumrepo {
        'mozilla-services-aws':
            baseurl  => 'https://s3.amazonaws.com/net.mozaws.prod.ops.rpmrepo/6/$basearch',
            descr    => 'services repo',
            enabled  => 1,
            priority => 5;
    }
}
