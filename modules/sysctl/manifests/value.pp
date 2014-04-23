define sysctl::value (
  $value
) {

  exec { "exec_sysctl_${name}":
    command     => "/sbin/sysctl ${name}='${value}'",
    refreshonly => true,
  }

  sysctl { $name:
    val    => $value,
    notify => Exec["exec_sysctl_${name}"],
  }

  augeas {
    $name:
      onlyif  => "get ${name} != '${value}'",
      context => '/files/etc/sysctl.conf',
      changes => "set ${name} '${value}'",
  }

}
