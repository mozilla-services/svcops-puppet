# elasticsearch config class
class elasticsearch::config(
    $cluster_name = undef,
    $nodes = undef,
    $datacenter = 'phx1',
    $es_data_path = '/var/lib/elasticsearch',
    $expected_nodes = '3',
    $nofile_limit = '65535',
    $cache_filter_size = '20%',
    $memory_size = ''
){
    if $memory_size == '' {
        $es_max_mem = inline_template('<%= @memorysize =~ /^(\d+)/; val = ( ( $1.to_i * 1024) / 1.50 ).to_i %>m')
    }
    else {
        $es_max_mem = $memory_size
    }

    $es_name = $::fqdn
    # make sure atleast 1 thread
    $es_threads = (($::processorcount/2) + 1)
    $es_bulk_threads = $::processorcount

    file {
        [
            '/var/log/elasticsearch',
            '/var/lib/elasticsearch',
            '/var/run/elasticsearch',
            $es_data_path,
        ]:
            ensure  => directory,
            owner   => "${elasticsearch::user}",
            mode    => '0755',
    }

    file {
        '/etc/security/limits.d/90-elasticsearch.conf':
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => "# THIS FILE MANAGED BY PUPPET.\n${elasticsearch::user} soft nofile ${nofile_limit}\n${elasticsearch::user} hard nofile ${nofile_limit}\n";
    }

    file {
        "${elasticsearch::config_dir}":
            ensure => directory,
            owner  => "${elasticsearch::user}";

        "${elasticsearch::config_dir}/elasticsearch.yml":
            ensure  => present,
            content => template('elasticsearch/elasticsearch.yml.erb'),
            owner   => "${elasticsearch::user}";

        "${elasticsearch::config_dir}/wordlist.txt":
            ensure  => present,
            content => template('elasticsearch/wordlist.txt'),
            owner   => "${elasticsearch::user}";

        "${elasticsearch::config_dir}/logging.yml":
            ensure  => present,
            content => template('elasticsearch/logging.yml.erb'),
            owner   => "${elasticsearch::user}";
    }

    file {
        '/etc/sysconfig/elasticsearch':
            ensure  => present,
            content => template('elasticsearch/sysconfig.erb')
    }

}
