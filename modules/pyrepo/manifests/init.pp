class pyrepo(
    $server_name
){
    include nginx

    file {
        '/data/pyrepo':
            owner => 'root',
            group => 'users',
            mode => '1775',
            ensure => 'directory';
    }

    nginx::config {
        'pyrepo':
            content => template('pyrepo/nginx/pyrepo.conf');
    }
}
