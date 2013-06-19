# $name is used for the clone location.
define git::clone(
    $repo
) {
    $clone_dir = $name

    exec {
        "/usr/bin/git clone ${repo} ${clone_dir}":
            creates => "${clone_dir}/.git";

        "git config remote.origin.url ${repo}":
            require => Exec["/usr/bin/git clone ${repo} ${clone_dir}"],
            path    => ['/usr/bin'],
            unless  => "test `git config remote.origin.url` = '${repo}'";
    }
}
