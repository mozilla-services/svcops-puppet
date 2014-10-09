# $name is used for the clone location.
define git::clone(
  $repo
) {
  contain git

  $clone_dir = $name

  exec {
    "git::clone::${clone_dir}":
      command => "/usr/bin/git clone ${repo} ${clone_dir}",
      creates => "${clone_dir}/.git";

    "git::config::${clone_dir}":
      command => "git config remote.origin.url ${repo}",
      require => Exec["git::clone::${clone_dir}"],
      cwd     => $clone_dir,
      path    => ['/usr/bin'],
      unless  => "test `git config remote.origin.url` = '${repo}'";
  }
}
