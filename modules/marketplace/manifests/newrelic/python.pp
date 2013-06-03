# defines newrelic config.
define marketplace::newrelic::python(
    $license_key
){
    include marketplace::newrelic

    $newrelic_name = $name

    file {
        "/etc/newrelic.d/${newrelic_name}.ini":
            content => template('marketplace/newrelic/python.ini');
    }
}
