PAYPAL_APP_ID = '<%= @addons_paypal_app_id %>'
PAYPAL_CGI_AUTH_PASSWORD = '<%= @addons_paypal_cgi_auth_password %>'
PAYPAL_CGI_AUTH_SIGNATURE = '<%= @addons_paypal_cgi_auth_signature %>'
PAYPAL_CGI_AUTH_USER = '<%= @addons_paypal_cgi_auth_user %>'
PAYPAL_CHAINS_EMAIL = '<%= @addons_paypal_chains_email %>'
PAYPAL_EMAIL = '<%= @addons_paypal_email %>'
PAYPAL_EMBEDDED_AUTH_PASSWORD = '<%= @addons_paypal_embedded_auth_password %>'
PAYPAL_EMBEDDED_AUTH_SIGNATURE = '<%= @addons_paypal_embedded_auth_signature %>'
PAYPAL_EMBEDDED_AUTH_USER = '<%= @addons_paypal_embedded_auth_user %>'
PAYPAL_EMBEDDED_PASSWORD = '<%= @addons_paypal_embedded_password %>'
PAYPAL_EMBEDDED_SIGNATURE = '<%= @addons_paypal_embedded_signature %>'
RESPONSYS_ID = '<%= @addons_responsys_id %>'
SECRET_KEY = '<%= @addons_secret_key %>'
SENTRY_DSN = '<%= @addons_sentry_dsn %>'
WEBAPPS_RECEIPT_KEY = '<%= @addons_webapps_receipt_key %>'
DOMAIN = '<%= @domain %>'
<% if @addons_static_url -%>
STATIC_URL = '<%= @addons_static_url %>'
<% end -%>
<% if @signing_server -%>
SIGNING_SERVER = '<%= @signing_server %>'
<% end -%>
