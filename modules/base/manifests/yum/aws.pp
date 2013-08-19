# class base yum aws this conflicts with base::yum
class base::yum::aws {
    yumrepo { 'mozilla-s3':
        baseurl        => 'https://s3-us-west-2.amazonaws.com/yumrepo.simplepush/',
        descr          => 'mozilla s3 repo',
        enabled        => 1,
        gpgcheck       => 0,
        priority       => 5,
        failovermethod => priority;
    }
}
