# class base yum aws this conflicts with base::yum
class base::yum::aws {
    @yumrepo { 'nginx':
        baseurl        => 'https://mrepo.mozilla.org/mrepo/6-$basearch/RPMS.nginx',
        descr          => 'nginx repo',
        enabled        => 1,
        gpgcheck       => 0,
        failovermethod => priority,
    }
}
