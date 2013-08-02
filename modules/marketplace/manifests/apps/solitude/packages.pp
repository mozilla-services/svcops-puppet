# marketplace packages
class marketplace::apps::solitude::packages {
    # These will probably need to be virtual someday
    package {
        'python-jinja2':
            ensure => '2.5.5-1';

        'python-lxml':
            ensure => '2.2.6-1';

        'python-markupsafe':
            ensure => '0.15-1';

        'python-pylibmc':
            ensure => '1.2.3-1';

        'python-simplejson':
            ensure => '2.3.2-1';

        'nodejs':
            ensure => '0.10.13-1.el6';

        'node-clean-css':
            ensure => '0.10.1-2';

        'node-less':
            ensure => '1.4.0-2';

        'node-stylus':
            ensure => '0.32.1-2';

        'node-uglify-js':
            ensure => '2.2.5-2';

        'MySQL-python':
            ensure => '1.2.3-0.3.c1.1.el6';

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
    }
}
