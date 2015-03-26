# olympia packages
class marketplace::apps::olympia::packages {
  include marketplace::virtual_packages
  realize Package[
    'python27-MySQL-python',
    'python27-m2crypto',
    'python27-pyOpenSSL',
    'python27-python',
    'python27-python-Pillow',
    'python27-python-cffi',
    'python27-python-crypto',
    'python27-python-cryptography',
    'python27-python-jinja2',
    'python27-python-lxml',
    'python27-python-markupsafe',
    'python27-python-simplejson',
    'python27-uwsgi'
  ]
}
