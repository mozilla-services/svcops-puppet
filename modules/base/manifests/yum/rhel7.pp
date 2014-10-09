# class base yum
class base::yum::rhel7 {
  include base::yum::conf

  yumrepo { 'mozilla-mkt':
    baseurl         => 'https://mrepo.mozilla.org/mrepo/$releasever-$basearch/RPMS.mozilla-mkt',
    descr           => 'Mozilla Marketplace Packages',
    enabled         => 1,
    priority        => 1,
    metadata_expire => 60,
    gpgcheck        => 0,
    cost            => '50',
    failovermethod  => 'priority',
  }

  yumrepo { 'puppetlabs':
    baseurl        => 'https://mrepo.mozilla.org/mrepo/$releasever-$basearch/RPMS.puppetlabs',
    enabled        => 1,
    priority       => 2,
    gpgcheck       => 0,
    failovermethod => 'priority',
  }

  yumrepo { 'puppetlabs-dependencies':
    baseurl        => 'https://mrepo.mozilla.org/mrepo/$releasever-$basearch/RPMS.puppetlabs-dependencies',
    enabled        => 1,
    priority       => 2,
    gpgcheck       => 0,
    failovermethod => 'priority',
  }

  yumrepo { 'epel':
    baseurl        => 'https://mrepo.mozilla.org/mrepo/$releasever-$basearch/RPMS.epel',
    descr          => 'EPEL',
    enabled        => 1,
    priority       => 2,
    gpgcheck       => 0,
    failovermethod => 'priority',
  }

  yumrepo { 'hp-utils':
    descr    => 'hp-utils',
    baseurl  => 'https://mrepo.mozilla.org/mrepo/$releasever-$basearch/RPMS.hp-utils',
    gpgcheck => 0,
    enabled  => 0;
  }

  yumrepo { 'nginx':
    baseurl        => 'https://mrepo.mozilla.org/mrepo/$releasever-$basearch/RPMS.nginx',
    descr          => 'nginx repo',
    enabled        => 0,
    gpgcheck       => 0,
    failovermethod => 'priority',
  }

  @yumrepo { 'mozilla-mysql':
    baseurl        => 'https://mrepo.mozilla.org/mrepo/$releasever--$basearch/RPMS.mozilla-mysql',
    descr          => 'Percona packages',
    enabled        => 0,
    priority       => 2,
    gpgcheck       => 0,
    failovermethod => 'priority',
  }

}
