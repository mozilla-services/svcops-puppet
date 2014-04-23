# pushgo ini
class pushgo::config(
  $elasticache_endpoint = 'localhost',
  $sslcert = undef,
  $sslkey = undef,
  $push_endpoint = undef
){
  file {
    '/etc/pushgo.ini':
      notify  => Exec['circus-restart-pushgo'],
      content => template('pushgo/config.ini');
  }
}
