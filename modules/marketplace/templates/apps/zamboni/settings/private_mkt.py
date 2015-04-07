APP_PURCHASE_SECRET = '<%= mkt_app_purchase_secret %>'
BLUEVIA_SECRET = '<%= mkt_bluevia_secret %>'
BROKER_URL = '<%= mkt_broker_url %>'
CARRIER_URLS = '<%= mkt_carrier_urls %>'
DEVELOPERS_OAUTH_KEY = '<%= mkt_developers_oauth_key %>'
DEVELOPERS_OAUTH_SECRET = '<%= mkt_developers_oauth_secret %>'
INAPP_KEY_PATH = '<%= mkt_inapp_key_path %>'
INAPP_KEY_PATHS = '<%= mkt_inapp_key_path %>'
MONOLITH_OAUTH_KEY = '<%= mkt_monolith_oauth_key %>'
MONOLITH_OAUTH_SECRET = '<%= mkt_monolith_oauth_secret %>'
MONOLITH_PASSWORD = '<%= mkt_monolith_password %>'
PAYPAL_APP_ID = '<%= mkt_paypal_app_id %>'
PAYPAL_CGI_AUTH_PASSWORD = '<%= mkt_paypal_cgi_auth_password %>'
PAYPAL_CGI_AUTH_SIGNATURE = '<%= mkt_paypal_cgi_auth_signature %>'
PAYPAL_CGI_AUTH_USER = '<%= mkt_paypal_cgi_auth_user %>'
PAYPAL_CHAINS_EMAIL = '<%= mkt_paypal_chains_email %>'
PAYPAL_EMAIL = '<%= mkt_paypal_email %>'
PAYPAL_EMBEDDED_AUTH_PASSWORD = '<%= mkt_paypal_embedded_auth_password %>'
PAYPAL_EMBEDDED_AUTH_SIGNATURE = '<%= mkt_paypal_embedded_auth_signature %>'
PAYPAL_EMBEDDED_AUTH_USER = '<%= mkt_paypal_embedded_auth_user %>'
PAYPAL_EMBEDDED_PASSWORD = '<%= mkt_paypal_embedded_password %>'
PAYPAL_EMBEDDED_SIGNATURE = '<%= mkt_paypal_embedded_signature %>'
SECRET_KEY = '<%= mkt_secret_key %>'
SENTRY_DSN = '<%= mkt_sentry_dsn %>'
SIGNED_APPS_KEY = '<%= mkt_signed_apps_key %>'
SIGNED_APPS_REVIEWER_SERVER = '<%= mkt_signed_apps_reviewer_server %>'
SIGNED_APPS_SERVER = '<%= mkt_signed_apps_server %>'
SIGNING_SERVER = '<%= mkt_signing_server %>'
SOLITUDE_OAUTH_KEY = '<%= mkt_solitude_oauth_key %>'
SOLITUDE_OAUTH_SECRET = '<%= mkt_solitude_oauth_secret %>'
WEBAPPS_RECEIPT_KEY = '<%= mkt_webapps_receipt_key %>'
WEBAPPS_RECEIPT_URL = '<%= mkt_webapps_receipt_url %>'
WEBTRENDS_PASSWORD = '<%= mkt_webtrends_password %>'
WEBTRENDS_USERNAME = '<%= mkt_webtrends_username %>'
<% if @mkt_domain -%>
DOMAIN = '<%= mkt_domain %>'
<% end -%>
<% if @mkt_static_url -%>
STATIC_URL = '<%= mkt_static_url %>'
<% end -%>

ALLOWED_CLIENTS_EMAIL_API = <%= mkt_allowed_clients_email_api %>

POSTFIX_AUTH_TOKEN = '<%= mkt_postfix_auth_token %>'

IARC_PASSWORD = '<%= mkt_iarc_password %>'

REDIS_BACKENDS_CACHE = '<%= mkt_redis_backends_cache %>'
REDIS_BACKENDS_CACHE_SLAVE = '<%= mkt_redis_backends_cache_slave %>'
REDIS_BACKENDS_MASTER = '<%= mkt_redis_backends_master %>'
REDIS_BACKENDS_SLAVE = '<%= mkt_redis_backends_slave %>'

FXA_CLIENT_ID = '<%= @fxa_client_id %>'
FXA_CLIENT_SECRET = '<%= @fxa_client_secret %>'
FXA_OAUTH_URL = '<%= @fxa_oauth_url %>'

PREVERIFIED_ACCOUNT_KEY = '<%= @preverified_account_key %>'

IAF_OVERRIDE_APPS = [
<% @iaf_override_apps.each do |val| -%>
        <%= val %>,
<% end -%>
]
