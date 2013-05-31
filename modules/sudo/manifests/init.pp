# vim: set expandtab ts=2 sw=2 filetype=puppet syntax=puppet:
#
# Class: sudo
#
# This module manages sudo
#
# Parameters:
#   [*config_dir*]
#     Main configuration directory
#     Default: '/etc/sudoers.d'
#
#   [*config_file*]
#     Main configuration file.
#     Default: '/etc/sudoers'
#
#   [*config_file_group*]
#     Main configuration file 'group' attribute.
#     Default: '/etc/sudoers'
#
#   [*config_file_replace*]
#     Replace configuration file with that one delivered with this module
#     Default: true
#
#   [*content*]
#     Alternate source file content
#     If you set this it overrides the $template parameter
#     Default: undef
#
#   [*ensure*]
#     Ensure for $package, $config_file, and $config_dir.
#     'absent' will remove $package, $config_file, and $config_dir
#     'present', 'latest', or a package version will set ensure => $ensure
#     on Package[$package] and ensure => directory/file on $config_dir and
#     $config_file.
#     Default: 'present'
#
#   [*package*]
#     Name of the package.
#     Default: 'sudo'
#
#   [*purge*]
#     Whether or not to purge sudoers.d directory
#     Default: true
#
#   [*source*]
#     Alternate source file location
#     If you set this it overrides the $template and $content parameters
#     Default: undef
#
#   [*template*]
#     Sets content of $config_file to template($template)
#     Default: 'sudo/sudoers'
#
# Actions:
#   Installs locales package and generates specified locales
#
# Requires:
#   Nothing
#
# Sample Usage:
#   class { 'sudo': }
#
# [Remember: No empty lines between comments and class definition]
class sudo(
  $config_dir = '/etc/sudoers.d/',
  $config_file = '/etc/sudoers',
  $config_file_group = 'root',
  $config_file_replace = true,
  $content = undef,
  $ensure = 'present',
  $package = 'sudo',
  $purge = true,
  $source = undef,
  $template = 'sudo/sudoers'
){

  $dir_ensure = $ensure ? {
    /^absent$/ => 'absent',
    default    => 'directory',
  }
  $file_ensure = $ensure ? {
    /^absent$/ => 'absent',
    default    => 'file',
  }

  if $source != undef {
    $content_real = undef
  } elsif $content != undef {
    $content_real = $content
  } else {
    $content_real = template($template)
  }

  package { $package:
    ensure => $ensure,
  }

  file {
    $config_file:
      ensure  => $file_ensure,
      content => $content_real,
      owner   => 'root',
      group   => $config_file_group,
      mode    => '0440',
      replace => $config_file_replace,
      source  => $source,
      require => Package[$package];
    $config_dir:
      ensure  => $dir_ensure,
      owner   => 'root',
      group   => $config_file_group,
      mode    => '0550',
      recurse => $purge,
      purge   => $purge,
      require => Package[$package];
  }
}
