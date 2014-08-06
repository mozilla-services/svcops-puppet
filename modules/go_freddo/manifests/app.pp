# go_freddo app
define go_freddo::app(
  $secret,

  $branches = {},
) {

  $app_name = $name
  concat::fragment { "go_freddo_${app_name}":
    target  => '/etc/go-freddo.toml',
    content => "[apps.${app_name}]\nsecret=\"${secret}\"\n\n",
  }

  create_resources(go_freddo::branch, $branches, {'app' => $app_name})
}
