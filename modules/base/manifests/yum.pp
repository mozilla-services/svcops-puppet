# class base yum
class base::yum {

  yumrepo { 'mozilla-services':
      baseurl        => 'https://mrepo.mozilla.org/mrepo/6-$basearch/RPMS.mozilla-services',
      descr          => 'Mozilla Services Packages',
      enabled        => 1,
      priority       => 1,
      gpgcheck       => 0,
      failovermethod => priority,
  }

  yumrepo { 'mozilla-mkt':
      baseurl        => 'https://mrepo.mozilla.org/mrepo/6-$basearch/RPMS.mozilla-mkt',
      descr          => 'Mozilla Marketplace Packages',
      enabled        => 1,
      gpgcheck       => 0,
      failovermethod => priority,
  }

  yumrepo { 'puppetlabs':
      baseurl        => 'https://mrepo.mozilla.org/mrepo/6-$basearch/RPMS.puppetlabs',
      descr          => 'Puppet Labs Products El 6 - $basearch',
      enabled        => 1,
      priority       => 1,
      gpgcheck       => 0,
      failovermethod => priority,
  }

  yumrepo { 'puppetlabs-dependencies':
      baseurl        => 'https://mrepo.mozilla.org/mrepo/6-$basearch/RPMS.puppetlabs-dependencies',
      descr          => 'Puppet Labs Dependencies El 6 - $basearch',
      enabled        => 1,
      priority       => 1,
      gpgcheck       => 0,
      failovermethod => priority,
  }

}
