# landfill requirements
class marketplace::landfill {
  file { '/usr/bin/landfill_dump':
    content => template('marketplace/landfill/landfill_dump'),
    mode    => '0755',
  }
}
