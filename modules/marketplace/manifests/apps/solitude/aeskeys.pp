# name is the root of the solitude checkout.
define marketplace::apps::solitude::aeskeys(
    $bango_signature_key,
    $buyerpaypal_key,
    $sellerbluevia_key,
    $sellerpaypal_id_key,
    $sellerpaypal_secret_key,
    $sellerpaypal_token_key,
    $sellerproduct_secret_key
) {
    $project_root = $name
    file {
        "${project_root}/aeskeys":
            ensure => directory;
    }
    file {
        "${project_root}/aeskeys/bango_signature.key":
            content => $bango_signature_key;
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
}
