# pushgo ini
class pushgo::config(
    $elasticache_endpoint = 'localhost'
){
    file {
        '/etc/pushgo.ini':
            content => file('pushgo/config.ini');
    }
}
