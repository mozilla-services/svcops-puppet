# base::hputils
class base::hputils {
  if $::manufacturer == 'HP' {
    package {
      'hpacucli':
        ensure => 'latest';

      'hpadu':
        ensure => 'latest';

      'hp-health':
        ensure => 'latest';

      'hponcfg':
        ensure => 'latest';

      'hpsmh':
        ensure => 'latest';

      'hp-snmp-agents':
        ensure => 'latest';
    }
  }
}
