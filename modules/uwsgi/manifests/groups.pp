# add uwsgi groups.
class uwsgi::groups {
    group {
        'uwsgi':
            ensure => present,
            gid    => '756';
    }
}
