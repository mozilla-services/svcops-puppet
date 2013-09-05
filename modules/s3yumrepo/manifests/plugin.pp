# add s3 yum plugin
class s3yumrepo::plugin {
    package {
        'yum-plugins-s3-iam':
            ensure => present;
    }
}
