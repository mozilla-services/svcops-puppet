# set up for deploytools
class fabdeploytools::deploytools(
    $fabric_version = 'present',
    $fpm_version = 'present',
    $fabdeploytools_version = 'present'
){
    package {
        'prelink':
            ensure => absent;
        'python-fabric':
            ensure => $fabric_version;
        'rubygem-fpm':
            ensure => $fpm_version;
        'python-fabdeploytools':
            ensure => $fabdeploytools_version;
    }

    file {
        '/etc/deploytools':
            ensure  => directory,
            recurse => true,
            purge   => true;
        '/etc/deploytools/envs':
            ensure  => directory,
            recurse => true,
            purge   => true;
    }
}
