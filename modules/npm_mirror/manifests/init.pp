# npm_mirror
class npm_mirror(
    $npm_mirror_dir = '/opt/npm_mirror'
    $giturl = 'https://github.com/mozilla-b2g/npm-mirror.git'
){

    git::clone {
        $npm_mirror_dir:
            repo => $giturl;
    }
}
