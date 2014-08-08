# zippy settings
# $ name is app root
define marketplace::apps::zippy::settings(
  $oauth_key,
  $oauth_secret,
  $session_secret,
  $signature_key,

  $oauth_realm = 'Zippy',
) {
  $app_root = $name
  file { "${app_root}/lib/config/local.js":
    content => template('marketplace/apps/zippy/local.js');
  }
}
