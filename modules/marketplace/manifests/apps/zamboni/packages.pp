# marketplace packages
class marketplace::apps::zamboni::packages {
  include marketplace::virtual_packages
  realize Package[
    'MySQL-python',
    'MySQL-shared',
    'm2crypto',
    'node-clean-css',
    'node-less',
    'node-stylus',
    'node-uglify-js',
    'nodejs',
    'pyOpenSSL',
    'python-crypto',
    'python-imaging',
    'python-jinja2',
    'python-lxml',
    'python-markupsafe',
    'python-pylibmc',
    'python-setproctitle',
    'python-simplejson',
    'python27-MySQL-python',
    'python27-m2crypto',
    'python27-python',
    'python27-python-lxml',
    'python27-uwsgi',
    'totem',
    'tracemonkey',
    'umemcache'
  ]
}
