# manage /dev/shm mount
class base::mounts::devshm(
  $options = 'noexec,nosuid,nodev',
){
  mount {
    '/dev/shm':
      ensure   => 'mounted',
      atboot   => true,
      fstype   => 'tmpfs',
      options  => $options,
      remounts => true,
  }
}
