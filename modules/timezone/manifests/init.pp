# sets system timezone.
class timezone(
    $timezone = 'UTC'
){

    package {
        'tzdata':
            ensure => 'present';
    }
    file {
        '/etc/localtime':
            require => Package['tzdata'],
            target  => "/usr/share/zoneinfo/${timezone}";
    }
}
