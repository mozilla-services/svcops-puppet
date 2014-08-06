# go_freddo branch
define go_freddo::branch(
  $app,
  $branch_ref,
  $script,
) {
  $branch_name = $name
  concat::fragment { "go_freddo_branch_${branch_name}":
    target  => '/etc/go-freddo.toml',
    content => "[[apps.${app}.branch]]\nref = \"${branch_ref}\"\nscript = \"${script}\"\n\n",
}
