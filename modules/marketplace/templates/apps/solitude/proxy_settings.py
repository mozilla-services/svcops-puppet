HMAC_KEYS = {
    '2013-02-20': '<%= hmac_key %>'
}

SECRET_KEY = '<%= secret_key %>'
SENTRY_DSN = '<%= sentry_dsn %>'

STATSD_HOST = '<%= statsd_host %>'
STATSD_PORT = <%= statsd_port %>
STATSD_PREFIX = '<%= cache_prefix %>'
CLIENT_JWT_KEYS = {}

PAYPAL_APP_ID = '<%= paypal_app_id %>'

PAYPAL_AUTH = {
    'USER': '<%= paypal_auth_user %>',
    'PASSWORD': '<%= paypal_auth_password %>',
    'SIGNATURE': '<%= paypal_auth_signature %>',
}

PAYPAL_CHAINS = (
    (30, '<%= paypal_chains %>'),
)

BANGO_AUTH = {
    'USER': '<%= bango_user %>',
    'PASSWORD': '<%= bango_password %>'
}
