# class base yum aws this conflicts with base::yum
class base::yum::aws {
    @yumrepo { 'nginx':
        baseurl        => 'http://nginx.org/packages/rhel/6/$basearch/',
        descr          => 'nginx repo',
        enabled        => 1,
        gpgcheck       => 0,
        failovermethod => priority,
    }
}
