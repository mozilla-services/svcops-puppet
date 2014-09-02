# class base yum
class base::yum {
  include base::yum::conf

  yumrepo {
    'rhel-source':
      descr    => 'Red Hat Enterprise Linux $releasever - $basearch - Source',
      baseurl  => 'ftp://ftp.redhat.com/pub/redhat/linux/enterprise/$releasever/en/os/SRPMS/',
      enabled  => 0,
      gpgcheck => 1,
      gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release';

    'rhel-source-beta':
      descr    => 'Red Hat Enterprise Linux $releasever Beta - $basearch - Source',
      baseurl  => 'ftp://ftp.redhat.com/pub/redhat/linux/beta/$releasever/en/os/SRPMS/',
      enabled  => 0,
      gpgcheck => 1,
      gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-beta,file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release';
  }

  yumrepo { 'mozilla-services':
    baseurl        => 'https://mrepo.mozilla.org/mrepo/6-$basearch/RPMS.mozilla-services',
    descr          => 'Mozilla Services Packages',
    enabled        => 1,
    priority       => 2,
    gpgcheck       => 0,
    exclude        => 'Percona-*',
    failovermethod => priority,
  }

  yumrepo { 'mozilla-mkt':
    baseurl         => 'https://mrepo.mozilla.org/mrepo/6-$basearch/RPMS.mozilla-mkt',
    descr           => 'Mozilla Marketplace Packages',
    enabled         => 1,
    priority        => 1,
    metadata_expire => 60,
    gpgcheck        => 0,
    cost            => '50',
    failovermethod  => priority,
  }

  yumrepo { 'puppetlabs':
    baseurl        => 'https://mrepo.mozilla.org/mrepo/6-$basearch/RPMS.puppetlabs',
    descr          => 'Puppet Labs Products El 6 - $basearch',
    enabled        => 1,
    priority       => 2,
    gpgcheck       => 0,
    failovermethod => priority,
  }

  yumrepo { 'puppetlabs-dependencies':
    baseurl        => 'https://mrepo.mozilla.org/mrepo/6-$basearch/RPMS.puppetlabs-dependencies',
    descr          => 'Puppet Labs Dependencies El 6 - $basearch',
    enabled        => 1,
    priority       => 2,
    gpgcheck       => 0,
    failovermethod => priority,
  }

  yumrepo { 'epel':
    baseurl        => 'https://mrepo.mozilla.org/mrepo/6-$basearch/RPMS.epel',
    descr          => 'EPEL',
    enabled        => 1,
    priority       => 2,
    gpgcheck       => 0,
    failovermethod => priority,
  }

  yumrepo { 'hp-utils':
    descr    => 'hp-utils',
    baseurl  => 'https://mrepo.mozilla.org/mrepo/6-$basearch/RPMS.hp-utils',
    gpgcheck => 0,
    enabled  => 1;
  }

  @yumrepo { 'epel-nagios':
    baseurl        =>
    'https://mrepo.mozilla.org/mrepo/$releasever-$basearch/RPMS.epel',
    descr          =>
    'Extra Packages for Enterprise Linux Nagios only $releasever - $basearch',
    enabled        => '1',
    includepkgs    => 'nagios*, nrpe*, nsca*, check-mk*',
    failovermethod => 'priority',
    gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
    gpgcheck       => '1',
    require        => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL'];
  }

  @yumrepo { 'rpmforge-extras':
    baseurl  => 'https://mrepo.mozilla.org/mrepo/$releasever-$basearch/RPMS.rpmforge-extras',
    descr    => 'Red Hat Enterprise $releasever - RPMforge.net - extras',
    enabled  => '0',
    protect  => '0',
    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
    gpgcheck => '1',
    exclude  => 'puppet*, facter, sox',
    require  => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag'];
  }

  yumrepo { 'nginx':
    baseurl        => 'https://mrepo.mozilla.org/mrepo/6-$basearch/RPMS.nginx',
    descr          => 'nginx repo',
    enabled        => 1,
    gpgcheck       => 0,
    failovermethod => priority,
  }

  @yumrepo { 'mariadb55':
    baseurl        => 'https://mrepo.mozilla.org/mrepo/$releasever-$basearch/RPMS.mariadb55',
    descr          => 'MariaDB packages',
    enabled        => 1,
    priority       => 2,
    gpgcheck       => 0,
    failovermethod => priority,
  }

  @yumrepo { 'percona':
    baseurl        => 'https://mrepo.mozilla.org/mrepo/$releasever-$basearch/RPMS.percona',
    descr          => 'Percona packages',
    enabled        => 1,
    priority       => 2,
    gpgcheck       => 0,
    failovermethod => priority,
  }

  @yumrepo { 'mozilla-mysql':
    baseurl        => 'https://mrepo.mozilla.org/mrepo/$releasever-$basearch/RPMS.mozilla-mysql',
    descr          => 'Percona packages',
    enabled        => 1,
    priority       => 2,
    gpgcheck       => 0,
    failovermethod => priority,
  }

  file {
    '/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL':
      ensure => present,
      source => 'puppet:///modules/base/rpm-gpg/RPM-GPG-KEY-EPEL-6';
    '/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag':
      ensure => present,
      source => 'puppet:///modules/base/rpm-gpg/RPM-GPG-KEY-rpmforge-dag';
  }
}
