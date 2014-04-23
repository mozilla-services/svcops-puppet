# profile.d entries
class base::profile(
  $tmout = 86400
) {
  file {
    '/etc/profile.d/timeout.sh':
      content => "export TMOUT=${tmout}";
  }
}
