# pushgo ini
class pushgo::config(
    $elasticache_endpoint = 'localhost'
){
    file {
        '/etc/pushgo.ini':
            notify  => Exec['circus-restart-pushgo'],
            content => template('pushgo/config.ini');
    }
}
