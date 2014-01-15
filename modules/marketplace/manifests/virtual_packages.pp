# marketplace virtual packages
class marketplace::virtual_packages {
    @package {
        'MySQL-python':
            ensure => '1.2.3-0.3.c1.1.el6';

        'pyOpenSSL':
            ensure => '0.13.1-1.el6';

        'python-jinja2':
            ensure => '2.5.5-1';

        'python-imaging':
            ensure => '1.1.7-19.el6';

        'python-lxml':
            ensure => '2.2.6-1';

        'python27-python-lxml':
            ensure => '2.2.6-1';

        'python27-MySQL-python':
            ensure => '1.2.3-9.el6';

        'python-markupsafe':
            ensure => '0.15-1';

        'python-pylibmc':
            ensure => '1.2.3-4';

        'python27-m2crypto':
            ensure => '0.21.1-1';

        'python27-python':
            ensure => '2.7.5-7.el6';

        'python27-uwsgi':
            ensure => '1.9.18.2-1';

        'python-simplejson':
            ensure => '2.3.2-1';

        'nodejs':
            ensure => '0.10.24-1.el6';

        'node-clean-css':
            ensure => '0.10.1-2';

        'node-less':
            ensure => '1.4.0-2';

        'node-stylus':
            ensure => '0.32.1-2';

        'node-uglify-js':
            ensure => '2.2.5-2';

        'tracemonkey':
            ensure => '27.0-a1';

        ['abrt', 'python-setproctitle']:
            ensure => absent;

        'abrt-cli':
            ensure => absent,
            before => [
                Package['abrt-addon-ccpp'],
                Package['abrt-addon-python'],
                Package['abrt-addon-kerneloops'],
            ];

        [
            'abrt-addon-ccpp',
            'abrt-addon-python',
            'abrt-addon-kerneloops',
        ]:
            ensure => absent,
            before => Package['abrt'];

        'umemcache':
            ensure => '1.6.3-1';
    }
}
