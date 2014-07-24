# mysq; for jenkins hosts
class jenkins::requirements::mysql (
  $cluster = 'addons-jenkins'
){
  $mysql_package_type = 'mysql56'
  $innodb_buffer_pool_size = inline_template('<%= @memorysize =~ /^(\d+)/; val = ( ( $1.to_i * 1024) / 12 ).to_i %>M')
  $key_buffer_size = inline_template('<%= @memorysize =~ /^(\d+)/; val = ( ( $1.to_i * 1024) / 24 ).to_i %>M')

  class {
    'mysql::server':
      server_role              => 'master',
      innodb_buffer_pool_size  => $innodb_buffer_pool_size,
      key_buffer_size          => $key_buffer_size,
      auto_increment_increment => 2,
      auto_increment_offset    => 1,
      max_connections          => 200,
      binlog_format            => 'MIXED',
      wait_timeout             => 60,
      swappiness               => '10',
      cluster                  => $cluster,
  }
}
