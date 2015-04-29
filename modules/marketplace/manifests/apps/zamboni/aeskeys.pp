# name is the root of the zamboni checkout.
define marketplace::apps::zamboni::aeskeys(
  $preverified_account_key,

  $cluster = undef,
  $env = undef,
) {
  $project_root = $name

  if $cluster and $env {
    Marketplace::Overlay {
      app     => 'zamboni-aeskeys',
      cluster => $cluster,
      env     => $env,
    }

    marketplace::overlay {
      "zamboni-aeskeys::keys::${name}::preverified_account.key":
        content  => $preverified_account_key,
        filename => 'preverified_account.key';
    }
  }
}
