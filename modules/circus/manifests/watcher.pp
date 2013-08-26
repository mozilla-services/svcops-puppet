# vim: set expandtab ts=2 sw=2 filetype=puppet syntax=puppet:
# FIXME std[err|out]_stream.*
# rlimit_* constants
define circus::watcher($cmd,
  $args = undef,
  $shell = undef,
  $working_dir = undef,
  $uid = 'root',
  $gid = 'root',
  $copy_env = undef,
  $copy_path = undef,
  $warmup_delay = 0,
  $autostart = undef,
  $numprocesses = 1,
  $rlimit_nofile = undef,
  $stderr_stream_class = undef,
  $stdout_stream_class = undef,
  $close_child_stdout = undef,
  $close_child_stderr = undef,
  $send_hup = undef,
  $max_retry = undef,
  $priority = undef,
  $singleton = undef,
  $use_sockets = undef,
  $max_age = undef,
  $max_age_variance = undef,
  $on_demand = undef,
  $virtualenv = undef,
  $respawn = undef,
  $check_flapping = true,
  $hooks = {}) {
  include circus::manager

  file {
    "/etc/circus.d/${name}.ini":
      ensure  => file,
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      content => template('circus/watcher.ini'),
      notify  => Exec['circus-initctl-reload'];
  }

  $defaults = {caller => $caller_module_name,}
  create_resources(circus::hook, $hooks, $defaults)

  exec {
    "circus-restart-${name}":
      refreshonly => true,
      command     => "/usr/bin/circusctl restart ${name}";
  }
}
