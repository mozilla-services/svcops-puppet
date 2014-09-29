# name is the root of the zamboni checkout.
define marketplace::apps::zamboni::aeskeys(
  $preverified_account_key,
) {
  $project_root = $name
  file { "${project_root}/aeskeys":
    ensure => 'directory';
  }
  file {
    "${project_root}/aeskeys/preverified_account.key":
      content => $preverified_account_key;
  }
}
