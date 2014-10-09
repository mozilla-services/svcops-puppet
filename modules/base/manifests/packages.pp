# base packages, we install these everywhere
class base::packages(
  $openssl_version = 'installed',
){

  $nc = $::operatingsystemmajrelease ? {
    '7'     => 'nmap-ncat',
    default => 'nc',
  }

  package {
    [
      'ack',
      'atop',
      'augeas',
      'bash',
      'bash-completion',
      'dstat',
      'htop',
      'nano',
      'strace',
      'sysstat',
      'telnet',
      'vim-enhanced',
      'zsh',
    ]:
      ensure => 'latest';
  }

  package {
    $nc:
      ensure => 'latest',
  }

  ##http://h10025.www1.hp.com/ewfrf/wc/document?cc=us&lc=en&docname=c03465358
  if $::manufacturer == 'HP' {
    package {
      [
        'glibc.i686',
        'libstdc++.i686',
        'libstdc++'
      ]:
        ensure => 'installed';
    }
  }

  package {
    'openssl':
      ensure => $openssl_version,
  }

  # remove abrt
  package {
    [
      'abrt',
      'abrt-cli',
      'abrt-libs',
      'abrt-tui',
    ]:
      ensure => 'absent',
  }

}
