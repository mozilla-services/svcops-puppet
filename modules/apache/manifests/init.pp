# this module is kind of weird, because there is a private httpd module.
class apache {
    $root = '/etc/httpd/conf.puppet.d'
    file {
        $root:
            ensure  => directory,
            purge   => true,
            recurse => true;
        '/etc/httpd/conf.d/apache.puppet.conf':
            content => "include conf.puppet.d/*.conf\n";
    }
}
