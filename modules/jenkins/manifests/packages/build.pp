# jenkins build packages
class jenkins::packages::build(
  $nodejs_version    = 'latest'
){
  # repos is needed for package installation
  realize Yumrepo['epel']
  realize Yumrepo['mozilla']
  realize Yumrepo['mozilla-mkt']

  # install virtualenv
  package {
    'virtualenv':
      ensure   => installed,
      provider => 'pip'
  }


  package {
    'stackato-client':
      ensure => installed;
    'npm':
      ensure => installed;
  }

  # python27 packages
  package {
    [
      'python27-MySQL-python',
      'python27-m2crypto',
      'python27-python',
      'python27-python-devel',
      'python27-python-jinja2',
      'python27-python-libs',
      'python27-python-lxml',
      'python27-python-simplejson',
      'python27-python-sqlalchemy',
      'python27-python-tools',
    ]:
      ensure  => installed,
      require => Yumrepo['mozilla-mkt']
  }

  # build requirements
  package {
    [
      'ant',
      'apache-maven',
      'bzr',
      'c-ares',
      'cmake',
      'cvs',
      'gcc-c++',
      'glibc-devel.i686',
      'glibc.i686',
      'libcurl-devel',
      'libevent',
      'libidn-devel',
      'libjpeg-turbo-devel',
      'libssh2-devel',
      'libstdc++.i686',
      'libtidy',
      'libxml2-devel',
      'libxslt-devel',
      'make',
      'ncurses-devel.i686',
      'openldap-devel',
      'python-devel',
      'python-pycurl',
      'python-pylibmc',
      'python-test',
      'python-tools',
      'rubygem-fpm',
      'swig',
      'vagrant',
      'zlib-devel.i686',
    ]:
      ensure  => installed,
      require => Yumrepo['mozilla']
  }

  package {
    'nodejs':
      ensure => $nodejs_version
  }
}
