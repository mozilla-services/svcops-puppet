import os
import sys
import dj_database_url

from default_settings import *

TEMPLATE_DEBUG = False

TESTING_MODE = False

TIME_ZONE = 'UTC'

SECRET_KEY = '<%= @secret_key %>'

MAX_THREADS = <%= @max_threads %>

ALLOWED_HOSTS = ['<%= @domain %>']

DATABASES = {}
DATABASES_DEFAULT_URL = '<%= @databases_default_url %>'
DATABASES['default'] = dj_database_url.parse(DATABASES_DEFAULT_URL)
DATABASES['default']['ENGINE'] = 'django.db.backends.mysql'
DATABASES['default']['OPTIONS'] = {'init_command': 'SET storage_engine=InnoDB'}


CACHE_PREFIX = '<%= cache_prefix %>'
CACHES_DEFAULT_LOCATION = '<%= @caches_default_location %>'

CACHES = {
    'default': {
        'BACKEND': "django.core.cache.backends.memcached.MemcachedCache",
        'LOCATION': splitstrip(CACHES_DEFAULT_LOCATION),
        'TIMEOUT': 500,
        'KEY_PREFIX': CACHE_PREFIX,
        }
    }

CACHES['distributed'] = CACHES['default']


def splitstrip(s):
    return [x.strip() for x in s.split(';')]
