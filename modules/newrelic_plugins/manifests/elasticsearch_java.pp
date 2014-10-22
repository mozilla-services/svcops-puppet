# = Class: newrelic_plugins::elasticsearch_java
#
# This class installs/configures/manages New Relic's ElasticSearch (Java) Plugin.
# Only supported on Debian-derived and Red Hat-derived OSes.
#
# == Parameters:
#
# $license_key::     License Key for your New Relic account
#
# $install_path::    Install Path for New Relic ElasticSearch (Java) Plugin.
#                    Any downloaded files will be placed here.
#                    The plugin will be installed within this
#                    directory at `newrelic_elasticsearch_java_plugin`.
#
# $user::            User to run as
#
# $version::         New Relic ElasticSearch (Java) Plugin Version.
#                    Currently defaults to the latest version.
#
# $servers::         Array of ElasticSearch server information.
#                    Note also that the "name" defaults to the same as the "host"
#                    unless overriden, and as such "name" is optional. Also if no
#                    "port" is provided, the default 11211 will be used.
#
# $java_options::    String of java options that will be passed to the init script java command.
#                    E.g. -Dhttps.proxyHost=proxy.example.com -Dhttps.proxyPort=12345
#                    for proxy support. Defaults to -Xmx128m (max 128mb heap size).
#
# == Requires:
#
#   puppetlabs/stdlib
#
# == Sample Usage:
#
#   class { 'newrelic_plugins::elasticsearch_java':
#     license_key    => 'NEW_RELIC_LICENSE_KEY',
#     install_path   => '/path/to/plugin',
#     user           => 'newrelic',
#     servers        => [
#       {
#         name  => 'Host - 1',
#         host  => 'localhost',
#         port  => 12510
#       },
#       {
#         name  => 'Host - 2',
#         host  => 'localhost'
#       }
#     ]
#   }
#
#   class { 'newrelic_plugins::elasticsearch_java':
#     license_key    => 'NEW_RELIC_LICENSE_KEY',
#     install_path   => '/path/to/plugin',
#     servers        => [
#       {
#         name          => 'Host - 1',
#         host          => 'localhost',
#         port          => 12510
#       }
#     ]
#   }
#
class newrelic_plugins::elasticsearch_java (
    $license_key = '',
    $install_path,
    $user,
    $version = $newrelic_plugins::params::elasticsearch_java_version,
    $servers,
  # $java_options = $newrelic_plugins::params::elasticsearch_java_options,
) inherits params {

  include stdlib

  # verify java is installed
  newrelic_plugins::resource::verify_java { 'ElasticSearch (Java) Plugin': }

  # verify attributes
  validate_absolute_path($install_path)
  validate_string($user)
  validate_string($version)
  validate_array($servers)

  # verify license_key
  newrelic_plugins::resource::verify_license_key { 'ElasticSearch (Java) Plugin: Verify New Relic License Key':
    license_key => $license_key
  }

  $plugin_path = "${install_path}/newrelic_elasticsearch_java_plugin"

  # install plugin
  newrelic_plugins::resource::install_plugin { 'newrelic_elasticsearch_java_plugin':
    install_path => $install_path,
    plugin_path  => $plugin_path,
    download_url => "${$newrelic_plugins::params::elasticsearch_java_download_baseurl}-${version}.tar.gz",
    version      => $version,
    user         => $user
  }

  # newrelic.properties template
  file { "${plugin_path}/config/newrelic.json":
    ensure  => file,
    content => template('newrelic_plugins/elasticsearch_java/newrelic.json.erb'),
    owner   => $user,
    notify  => Service['newrelic-elasticsearch-java-plugin']
  }

  # elasticsearch.hosts.json template
  file { "${plugin_path}/config/plugin.json":
    ensure  => file,
    content => template('newrelic_plugins/elasticsearch_java/plugin.json.erb'),
    owner   => $user,
    notify  => Service['newrelic-elasticsearch-java-plugin']
  }

  # install init.d script and start service
  newrelic_plugins::resource::plugin_service { 'newrelic-elasticsearch-java-plugin':
    daemon         => 'plugin.jar',
    daemon_dir     => $plugin_path,
    plugin_name    => 'ElasticSearch (Java)',
    plugin_version => $version,
    user           => $user,
    run_command    => "java ${java_options} -jar",
    service_name   => 'newrelic-elasticsearch-java-plugin'
  }

  # ordering
  Newrelic_plugins::Resource::Verify_java['ElasticSearch (Java) Plugin']
  ->
  Newrelic_plugins::Resource::Verify_license_key['ElasticSearch (Java) Plugin: Verify New Relic License Key']
  ->
  Newrelic_plugins::Resource::Install_plugin['newrelic_elasticsearch_java_plugin']
  ->
  File["${plugin_path}/config/newrelic.json"]
  ->
  File["${plugin_path}/config/plugin.json"]
  ->
  Newrelic_plugins::Resource::Plugin_service['newrelic-elasticsearch-java-plugin']
}

