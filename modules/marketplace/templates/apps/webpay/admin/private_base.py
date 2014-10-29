DATABASES_DEFAULT_URL = '<%= database_default_url %>'
DATABASES_SLAVE_URL = '<%= database_slave_url %>'
CACHE_PREFIX = '<%= cache_prefix %>'
CACHES_DEFAULT_LOCATION = '<%= caches_default_location %>'

HMAC_KEYS = <%= hmac_keys %>

SECRET_KEY = '<%= secret_key %>'

BROKER_URL = '<%= broker_url %>'
SYSLOG_TAG = '<%= syslog_tag %>'
KEY = '<%= key %>'
SECRET = '<%= secret %>'

SENTRY_DSN = '<%= sentry_dsn %>'

MARKETPLACE_OAUTH_KEY = '<%= mkt_oauth_key %>'
MARKETPLACE_OAUTH_SECRET = '<%= mkt_oauth_secret %>'

SOLITUDE_OAUTH_KEY = '<%= solitude_oauth_key %>'
SOLITUDE_OAUTH_SECRET = '<%= solitude_oauth_secret %>'

STATSD_HOST = '<%= statsd_host %>'
STATSD_PORT = 8125
STATSD_PREFIX = '<%= statsd_prefix %>'

UUID_HMAC_KEY = '<%= uuid_hmac_key %>'

ENCRYPTED_COOKIE_KEY = '<%= encrypted_cookie_key %>'

ZAMBONI_SHARED_KEY = '<%= @zamboni_shared_key %>'

FXA_CLIENT_ID = '<%= @fxa_client_id %>'
FXA_CLIENT_SECRET = '<%= @fxa_client_secret %>'
