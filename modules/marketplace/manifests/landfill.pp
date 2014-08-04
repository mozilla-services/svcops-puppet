# landfill requirements
class marketplace::landfill {
  file { '/data/landfilldisabled':
    ensure => 'directory',
  }
  file { '/data/landfilldisabled/disabled.txt':
    content => 'landfill is currently offline. Join us in #amo and #marketplace for AMO and Marketplace development chat.',
  }
  file { '/usr/bin/landfill_dump':
    content => template('marketplace/landfill/landfill_dump'),
    mode    => '0755',
  }
}
