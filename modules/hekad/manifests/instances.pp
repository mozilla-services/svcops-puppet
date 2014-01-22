#hekad instances class
class hekad::instances(
    $instances = {},
) {
    create_resources(hekad::instance, $instances)
}
