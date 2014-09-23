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
        'LOCATION': CACHES_DEFAULT_LOCATION.split(';'),
        'TIMEOUT': 500,
        'KEY_PREFIX': CACHE_PREFIX,
        }
    }

CACHES['distributed'] = CACHES['default']


INSTALLED_APPS = (
    # Apps need for the recommendation
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.staticfiles",
    # Recommendation apps
    "recommendation",
    "recommendation.api",
    "recommendation.filter_owned",
    "recommendation.language",
    "recommendation.simple_logging",
)

# Middleware needed
MIDDLEWARE_CLASSES = [
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.middleware.transaction.TransactionMiddleware",
    "django.middleware.cache.UpdateCacheMiddleware",
    "django.middleware.cache.FetchFromCacheMiddleware",
]
