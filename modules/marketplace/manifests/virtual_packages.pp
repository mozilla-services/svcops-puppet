# marketplace virtual packages
class marketplace::virtual_packages {
  @package {
    'firefox':
      ensure => 'installed';

    'MySQL-python':
      ensure => '1.2.3-0.3.c1.1.el6';

    'MySQL-shared':
      ensure => '5.6.12-2.el6';

    'm2crypto':
      ensure => '0.22.3-1.el6';

    'pngcrush':
      ensure => '1.7.73-1.el6.rf';

    'pngnq':
      ensure => '1.1-5.el6';

    'pyOpenSSL':
      ensure => '0.13.1-1.el6';

    'python-crypto':
      ensure => '2.6.1-1.el6.rfx';

    'python-jinja2':
      ensure => '2.7.2-1.el6';

    'python-imaging':
      ensure => '1.1.7-19.el6';

    'python-lxml':
      ensure => '2.2.6-1';

    'python27-pyOpenSSL':
      ensure => '0.14-1.el6';

    'python27-python-crypto':
      ensure => '2.6.1-2.el6';

    'python27-python-cryptography':
      ensure => '0.8-1.el6';

    'python27-python-cffi':
      ensure => '0.9.1-1.el6';

    'python27-python-markupsafe':
      ensure => '0.18-1.el6';

    'python27-python-simplejson':
      ensure => 'absent';

    'python27-python-jinja2':
      ensure => '2.7.2-1.el6';

    'python27-python-Pillow':
      ensure => '2.7.0-1.el6';

    'python27-python-lxml':
      ensure => '2.2.6-1';

    'python27-python-pylibmc':
      ensure => '1.2.3-1';

    'python27-MySQL-python':
      ensure => '1.2.3-9.el6';

    'python-markupsafe':
      ensure => '0.15-1';

    'python-pylibmc':
      ensure => '1.2.3-4';

    'python27-m2crypto':
      ensure => '0.22.3-2.el6';

    'python27-python':
      ensure => '2.7.5-7.el6';

    'python27-uwsgi':
      ensure => '1.9.18.2-1';

    'python-simplejson':
      ensure => '2.3.2-1';

    'nodejs':
      ensure => '0.10.28-1.el6';

    'node-clean-css':
      ensure => '0.10.1-2';

    'node-less':
      ensure => '1.4.0-2';

    'node-stylus':
      ensure => '0.32.1-2';

    'node-uglify-js':
      ensure => '2.2.5-2';

    'totem':
      ensure => 'installed';

    'tracemonkey':
      ensure => '40.0a2-1.el6';

    'umemcache':
      ensure => '1.6.3-1';

    'python-setproctitle':
      ensure => 'absent';
  }
}
