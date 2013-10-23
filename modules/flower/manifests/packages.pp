# packages for flower

class flower::packages {
    package {
        'flower':
            ensure => present;
    }
}
