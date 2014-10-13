# elasticsearch chroot
class elasticsearch::chroot(
  $memory_size,
  $cache_filter_size = '20%',
  $cluster_name = undef,
  $datacenter = 'phx1',
  $es_data_path = '/var/lib/elasticsearch',
  $expected_nodes = '3',
  $http_port = '10200',
  $memlock_limit = 'unlimited',
  $nodes = undef,
  $nofile_limit = '65535',
  $tcp_port = '10300',
  $version = '1.3.4',
){

  $es_max_mem = $memory_size
  $es_name = $::fqdn

  $chroot_dir = "/data/chroot/elasticsearch-${version}"
  $config_dir = "${chroot_dir}/etc/elasticsearch"

  # make sure atleast 1 thread
  $es_threads = (($::processorcount/2) + 1)
  $es_bulk_threads = $::processorcount

  File {
    require => Package['chroot-elasticsearch'],
  }

  package {
    'chroot-elasticsearch':
      ensure => 'installed',
  }

  file {
    "${chroot_dir}/etc/security/limits.d/90-elasticsearch.conf":
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('elasticsearch/limits.conf');

    "${config_dir}/elasticsearch.yml":
      ensure  => 'file',
      content => template('elasticsearch/elasticsearch.yml.erb');

    "${config_dir}/wordlist.txt":
      ensure  => 'file',
      content => template('elasticsearch/wordlist.txt');

    "${config_dir}/logging.yml":
      ensure  => 'file',
      content => template('elasticsearch/logging.yml.erb');

    "${chroot_dir}/etc/sysconfig/elasticsearch":
      ensure  => 'file',
      content => template('elasticsearch/sysconfig.erb');
  }

}
