# elasticsearch plugins class
class elasticsearch::plugins(
    $plugins = undef
){

    package {
        $plugins:
            ensure  => present;
    }
}
