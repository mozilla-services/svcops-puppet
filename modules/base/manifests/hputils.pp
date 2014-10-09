# base::hputils
class base::hputils {
  if $::manufacturer == 'HP' {
    package {
      'hp-health':
        ensure => 'latest';

      'hponcfg':
        ensure => 'latest';

      'hpsmh':
        ensure => 'latest';

      'hp-snmp-agents':
        ensure => 'latest';
    }
    case $::operatingsystemmajrelease {
      '6': {
        package {
          'hpacucli':
            ensure => 'latest';

          'hpadu':
            ensure => 'latest';
        }
      }
      '7': {
        package {
          'hpssacli':
            ensure => 'latest';

          'hpssa':
            ensure => 'latest';
        }
      }
      default: { }
    }

  }
}
