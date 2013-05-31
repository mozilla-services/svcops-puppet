# vim: set expandtab ts=2 sw=2 filetype=puppet syntax=puppet:
#
# Define: sudo::conf
#
# This module manages sudoa configurations
#
# Parameters:
#   [*ensure*]
#     Ensure if present or absent.
#     Default: present
#
#   [*priority*]
#     Prefix file name with $priority
#     Default: 10
#
#   [*content*]
#     Content of configuration snippet.
#     Default: undef
#
#   [*source*]
#     Source of configuration snippet.
#     Default: undef
#
#   [*sudo_config_dir*]
#     Where to place configuration snippets.
#     Only set this, if your platform is not supported or
#     you know, what you're doing.
#     Default: auto-set, platform specific
#
# Actions:
#   Installs sudo configuration snippets
#
# Requires:
#   Class sudo
#
# Sample Usage:
#   sudo::conf { 'admins':
#     source => 'puppet:///files/etc/sudoers.d/admins',
#   }
#
# [Remember: No empty lines between comments and class definition]
define sudo::conf(
  $ensure = present,
  $priority = 10,
  $content = undef,
  $source = undef
) {
  include sudo

  Class['sudo'] -> Sudo::Conf[$name]

  if $content != undef {
    $content_real = "${content}\n"
  } else {
    $content_real = undef
  }

  file { "${priority}_${name}":
    ensure  => $ensure,
    path    => "${::sudo::config_dir}${priority}_${name}",
    owner   => 'root',
    group   => $::sudo::config_file_group,
    mode    => '0440',
    source  => $source,
    content => $content_real,
  }
}
