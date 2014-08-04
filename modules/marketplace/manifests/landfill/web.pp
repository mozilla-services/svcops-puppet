# marketplace landfill web
class marketplace::landfill::web {
  file { '/data/landfilldisabled':
    ensure => 'directory',
  }
  file { '/data/landfilldisabled/disabled.txt':
    content => 'landfill is currently offline. Join us in #amo and #marketplace for AMO and Marketplace development chat.',
  }->
  nginx::config {
    'landfill-addons':
      content => template('marketplace/nginx/landfill/landfill.addons.allizom.org.conf');
    'landfill-marketplace':
      content => template('marketplace/nginx/landfill/landfill.marketplace.allizom.org.conf');
  }

  nginx::logdir {
    ['landfill-addons.allizom.org',
    'landfill-mkt.allizom.org']:
  }
}
