# base::hputils
class base::hputils {
  if $::manufacturer == 'HP' {
    package {
      'hpacucli':
        ensure => 'installed';

      'hpadu':
        ensure => 'installed';

      'hp-health':
        ensure => 'installed';

      'hponcfg':
        ensure => 'installed';

      'hpsmh':
        ensure => 'installed';

      'hp-snmp-agents':
        ensure => 'installed';
    }
  }
}
