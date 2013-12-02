# marketplace trunion packages class.
class marketplace::apps::trunion::packages{

    package {
        [
            'm2crypto',
            'python-PyJWT'
        ]:
            ensure => present
    }
}
