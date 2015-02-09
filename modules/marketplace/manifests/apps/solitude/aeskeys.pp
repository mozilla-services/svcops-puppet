# name is the root of the solitude checkout.
define marketplace::apps::solitude::aeskeys(
  $bango_signature_key,
  $buyeremail_key,
  $buyerpaypal_key,
  $sellerbluevia_key,
  $sellerpaypal_id_key,
  $sellerpaypal_secret_key,
  $sellerpaypal_token_key,
  $sellerproduct_secret_key,

  $cluster = undef,
  $env = undef,
) {
  $project_root = $name
  file { "${project_root}/aeskeys":
    ensure => 'directory';
  }
  file {
    "${project_root}/aeskeys/bango_signature.key":
      content => $bango_signature_key;
    "${project_root}/aeskeys/buyeremail.key":
      content => $buyeremail_key;
    "${project_root}/aeskeys/buyerpaypal.key":
      content => $buyerpaypal_key;
    "${project_root}/aeskeys/sellerbluevia.key":
      content => $sellerbluevia_key;
    "${project_root}/aeskeys/sellerpaypal_id.key":
      content => $sellerpaypal_id_key;
    "${project_root}/aeskeys/sellerpaypal_secret.key":
      content => $sellerpaypal_secret_key;
    "${project_root}/aeskeys/sellerpaypal_token.key":
      content => $sellerpaypal_token_key;
    "${project_root}/aeskeys/sellerproduct_secret.key":
      content => $sellerproduct_secret_key;
  }

  if $cluster and $env {
    Marketplace::Overlay {
      app     => 'solitude-aeskeys',
      cluster => $cluster,
      env     => $env,
    }

    marketplace::overlay {
      "solitude-aeskeys::keys::${name}::bango_signature.key":
        content  => $bango_signature_key,
        filename => 'bango_signature.key';

      "solitude-aeskeys::keys::${name}::buyeremail.key":
        content  => $buyeremail_key,
        filename => 'buyeremail.key';

      "solitude-aeskeys::keys::${name}::buyerpaypal.key":
        content  => $buyerpaypal_key,
        filename => 'buyerpaypal.key';

      "solitude-aeskeys::keys::${name}::sellerbluevia.key":
        content  => $sellerbluevia_key,
        filename => 'sellerbluevia.key';

      "solitude-aeskeys::keys::${name}::sellerpaypal_id.key":
        content  => $sellerpaypal_id_key,
        filename => 'sellerpaypal_id.key';

      "solitude-aeskeys::keys::${name}::sellerpaypal_secret.key":
        content  => $sellerpaypal_secret_key,
        filename => 'sellerpaypal_secret.key';

      "solitude-aeskeys::keys::${name}::sellerpaypal_token.key":
        content  => $sellerpaypal_token_key,
        filename => 'sellerpaypal_token.key';

      "solitude-aeskeys::keys::${name}::sellerproduct_secret.key":
        content  => $sellerproduct_secret_key,
        filename => 'sellerproduct_secret.key';
    }
  }
}
