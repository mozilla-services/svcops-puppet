# fabdeploytools deployserver env
define fabdeploytools::deployserver::env() {
    $env_name = $name
    file {
        "${fabdeploytools::deployserver::package_root}/${env_name}":
            ensure => directory;
    }
}
