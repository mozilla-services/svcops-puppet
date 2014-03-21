CLUSTER = '<%= cluster %>'
DOMAIN = '<%= domain %>'
ENV = '<%= env %>'
SSH_KEY = '<%= ssh_key %>'
PYREPO = '<%= pyrepo %>'
CRON_NAME = '<%= cron_name %>'
UWSGI = filter(None, '<%= uwsgi %>'.split(';'))
CELERY_SERVICE_PREFIX = <% if celery_service_prefix %>'<%= celery_service_prefix %>'<% else %>None<% end %>
CELERY_SERVICE_MKT_PREFIX = '<%= celery_service_mkt_prefix %>'
LOAD_TESTING = <%= load_testing %>
UPDATE_REF = <% if update_ref %>'<%= update_ref %>'<% else %>None<% end %>
DEV = <%= dev ? 'True' : 'False' %>
CRON_USER = '<%= cron_user %>'
