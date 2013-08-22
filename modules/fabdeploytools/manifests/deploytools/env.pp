# defines host environments
define fabdeploytools::deploytools::env(
    $hostcontent # this is a json string in the format: {"TYPE": ['host1', 'host2']}
) {
    $env_name = $name

    include fabdeploytools::deploytools

    file {
        "/etc/deploytools/envs/${env_name}":
            content  => $hostcontent;
    }
}
