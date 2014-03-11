# manage /dev/shm mount
class base::mounts::devshm {
  mount {
    '/dev/shm':
      ensure   => 'mounted',
      atboot   => true,
      fstype   => 'tmpfs',
      options  => 'noexec,nosuid,nodev',
      remounts => true,
  }
}
