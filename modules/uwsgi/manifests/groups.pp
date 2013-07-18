class uwsgi::groups {
    group {
        'uwsgi':
            gid    => '756',
            ensure => present;
    }
}
