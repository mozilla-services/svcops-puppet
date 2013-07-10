# fabdeploytools deployserver env
define fabdeploytools::deployserver::env() {
    $env_name = $name
    file {
        "${fabdeploytools::deployserver::root}/${env_name}":
            ensure => directory;
    }
}
