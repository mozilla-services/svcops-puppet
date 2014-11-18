# web instance class
class marketplace::apps::frappe::web(
  $instances = {},
  $user,
  $uid,
) {

  package {
    'atlas':
      ensure => 'installed';
  }

  user {
    $user:
      shell  => '/sbin/nologin',
      uid    => $uid,
      groups => 'uwsgi';
  }

  create_resources(
    marketplace::apps::frappe::web_instance,
    $instances,
    {'user' => $user},
  )
}
