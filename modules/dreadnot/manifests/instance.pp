# start dreadnot instance.
define dreadnot::instance(
  $instance_description = 'Deployer',
  $default_url = 'http://localhost/',
  $env = 'dev',
  $secure = false,
  $github_org = 'mozilla',
  $htpasswd = '',
  $port = '9000'
) {
  include dreadnot

  $instance_name = $name
  $root = "${dreadnot::instance_root}/${instance_name}"
  $data_root = "/var/dreadnot/${instance_name}"
  file {
    $root:
      ensure => directory;
    "${root}/stacks":
      ensure => directory;
    "${root}/htpasswd":
      content => $htpasswd,
      notify  => Service["dreadnot-${instance_name}"];
    "/var/dreadnot/${instance_name}":
      ensure => directory;
  }
  concat {
    "${root}/settings.js":
      require => File[$root],
      notify  => Service["dreadnot-${instance_name}"];
  }

  concat::fragment {
    "settings_${instance_name}_header.js":
      target  => "${root}/settings.js",
      content => template('dreadnot/settings_header.js'),
      order   => 01;

    "settings_${instance_name}_footer.js":
      target  => "${root}/settings.js",
      content => template('dreadnot/settings_footer.js'),
      order   => 10;
  }

  supervisord::service {
    "dreadnot-${instance_name}":
      command => "/opt/dreadnot/bin/dreadnot -c ${root}/settings.js -s ${root}/stacks -p ${port}",
      app_dir => $data_root,
      user    => 'root';
  }
}
