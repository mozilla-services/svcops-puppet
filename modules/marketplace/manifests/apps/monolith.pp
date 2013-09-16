# monolith
define marketplace::apps::monolith(
    $project_dir,
    $workers = 4,
    $port = '12000',
    $user = 'mkt_prod_monolith'
) {
    $uwsgi_name = $name

    uwsgi::instance {
        $uwsgi_name:
            app_dir   => "${project_dir}/monolith",
            appmodule => "runserver:application",
            port      => $port,
            home      => "${project_dir}/venv",
            user      => $user,
            workers   => $workers;
    }
}
