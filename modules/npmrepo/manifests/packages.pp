class npmrepo::packages{
  
  package { 'nodejs':
    ensure => 'latest';
  }

  package { 'npm-lazy-mirror':
    ensure => 'latest'
  }
}
