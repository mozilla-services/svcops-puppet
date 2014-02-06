class npmrepo::packages{
  include nodejs
  
  package { 'npm-lazy-mirror':
    ensure => 'latest'
  }
}
