# outgoing_redirector https://github.com/oremj/outgoing/
class outgoing_redirector(
    $version = '0.0.1-r1.331e86ecf4e7.el6'
) {
    package { 'outgoing-redirector':
        ensure => $version
    }
}
