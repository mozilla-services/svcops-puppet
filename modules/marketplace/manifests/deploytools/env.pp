# defines host environments
define marketplace::deploytools::env(
    $hostcontent # this is a json string in the format: {"TYPE": ['host1', 'host2']}
) {
    $env_name = $name

    include marketplace::deploytools

    file {
        "/etc/deploytools/envs/${env_name}":
            content  => $hostcontent;
    }
}
