DATABASES_DEFAULT_URL = '<%= @db_url %>'
HMAC_KEYS = {
    '2013-02-01': '<%= @hmac_key %>'
}

SECRET_KEY = '<%= @secret_key %>'
SENTRY_DSN = '<%= @sentry_dsn %>'

STATSD_HOST = '<%= @statsd_host %>'
STATSD_PORT = <%= @statsd_port %>
STATSD_PREFIX = '<%= @cache_prefix %>'


AES_KEYS = {
    'bango:signature': '<%= @aes_key_dir %>/bango_signature.key',
    'buyerpaypal:key': '<%= @aes_key_dir %>/buyerpaypal.key',
    'sellerbluevia:id': '<%= @aes_key_dir %>/sellerbluevia.key',
    'sellerpaypal:id': '<%= @aes_key_dir %>/sellerpaypal_id.key',
    'sellerpaypal:token': '<%= @aes_key_dir %>/sellerpaypal_token.key',
    'sellerpaypal:secret': '<%= @aes_key_dir %>/sellerpaypal_secret.key',
    'sellerproduct:secret': '<%= @aes_key_dir %>/sellerproduct_secret.key',
}

CLIENT_JWT_KEYS = {}

PAYPAL_PROXY = '<%= @solitude_proxy %>/proxy/paypal'
BANGO_PROXY = '<%= @solitude_proxy %>/proxy/bango'

CLIENT_OAUTH_KEYS = {
    'webpay': '<%= @webpay_oauth_secret %>',
    'marketplace': '<%= @mkt_oauth_secret %>'
}

BANGO_BASIC_AUTH = <%= @bango_basic_auth %>
S3_AUTH_KEY = '<%= @s3_auth_key %>'
S3_AUTH_SECRET = '<%= @s3_auth_secret %>'
S3_BUCKET = '<%= @s3_bucket %>'
