# mount pyrepo nfs
class pyrepo::nfs(
    $host,
    $path,
    $pyrepo_dir = '/data/pyrepo',
    $rw = true,
    $mkdir = false
){
    nfsclient::mount {
        $pyrepo_dir:
            host  => $host,
            path  => $path,
            rw    => $rw,
            mkdir => $mkdir
    }
}
