CLUSTER = '<%= cluster %>'
DOMAIN = '<%= domain %>'
ENV = '<%= env %>'
SSH_KEY = '<%= ssh_key %>'
PYREPO = '<%= pyrepo %>'
CRON_NAME = '<%= cron_name %>'
GUNICORN = '<%= gunicorn %>'.split(';')
MULTI_GUNICORN = '<%= multi_gunicorn %>'.split(';')
CELERY_SERVICE_PREFIX = '<%= celery_service_prefix %>'
CELERY_SERVICE_MKT_PREFIX = '<%= celery_service_mkt_prefix %>'
LOAD_TESTING = <%= load_testing %>
UPDATE_REF = <% if update_ref %>'<%= update_ref %>'<% else %>None<% end %>
