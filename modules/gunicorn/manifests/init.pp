class gunicorn(
    $user = "apache",
    $version = "0.14.5-1"
){
    file {
        "/var/log/gunicorn":
            owner => $user,
            group => $user,
            ensure => "directory",
            mode => '0755';
        "/etc/gunicorn":
            ensure => "directory",
            recurse => true,
            purge => true;
        "/etc/gunicorn/rewritemap.d":
            ensure => "directory",
            notify => Exec["gunicorn-rewritemap"],
            recurse => true,
            purge => true;
        "/etc/gunicorn/nginx-upstream/":
            ensure => "directory",
            recurse => true,
            purge => true;
        "/etc/gunicorn/rewritemap":
            mode => '0644';
    }

    exec {
        "gunicorn-rewritemap":
            command => "/bin/cat /etc/gunicorn/rewritemap.d/* > /etc/gunicorn/rewritemap",
            refreshonly => true,
            require => File["/etc/gunicorn/rewritemap.d"];
    }

    package {
        "gunicorn":
            ensure => $version;
    }

    motd {
        '0-gunicorn':
            order => "11",
            content => "Gunicorns:\n";
    }

}
