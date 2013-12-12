# marketplace packages
class marketplace::apps::zamboni::packages {
    include marketplace::virtual_packages
    realize Package['abrt',
                    'abrt-addon-ccpp',
                    'abrt-addon-kerneloops',
                    'abrt-addon-python',
                    'abrt-cli',
                    'MySQL-python',
                    'node-clean-css',
                    'node-less',
                    'node-stylus',
                    'node-uglify-js',
                    'nodejs',
                    'pyOpenSSL',
                    'python-imaging',
                    'python-jinja2',
                    'python-lxml',
                    'python-markupsafe',
                    'python-pylibmc',
                    'python-setproctitle',
                    'python-simplejson',
                    'tracemonkey',
                    'umemcache'
    ]
}
