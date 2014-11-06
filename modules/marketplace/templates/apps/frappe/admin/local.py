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
    "default": {
        "BACKEND": "django.core.cache.backends.memcached.MemcachedCache",
        "LOCATION": CACHES_DEFAULT_LOCATION.split(";"),
        "TIMEOUT": 500,
        "KEY_PREFIX": CACHE_PREFIX,
        },
    "local": {
        "BACKEND": "django.core.cache.backends.locmem.LocMemCache",
        "LOCATION": "django_default_cache",
        "OPTIONS": {"MAX_ENTRIES": 10000000}
    },
    "userfactors": {
        "BACKEND": "uwsgicache.UWSGICache",
        "LOCATION": "userfactors"
    }
}

MIDDLEWARE_CLASSES = [
    "django.contrib.sessions.middleware.SessionMiddleware",
    "corsheaders.middleware.CorsMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.transaction.TransactionMiddleware",
    "django.middleware.cache.UpdateCacheMiddleware",
    "django.middleware.cache.FetchFromCacheMiddleware",
]

RESPONSE_TIMEOUT = 1
