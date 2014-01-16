# base yum.conf
class base::yum::conf {
    file { '/etc/yum.conf':
        content => template('base/yum.conf'),
    }
}
