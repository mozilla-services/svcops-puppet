CLUSTER = '<%= @cluster %>'
DOMAIN = '<%= @domain %>'
ENV = '<%= @env %>'
SSH_KEY = '<%= @ssh_key %>'
PYREPO = '<%= @pyrepo %>'
CRON_NAME = '<%= @cron_name %>'
UWSGI = filter(None, '<%= @uwsgi %>'.split(';'))
CELERY_SERVICE_PREFIX = '<%= @celery_service_prefix %>'
UPDATE_REF = <% if update_ref %>'<%= @update_ref %>'<% else %>None<% end %>
LOAD_TESTING = False
DEV = <%= dev ? 'True' : 'False' %>
CRON_USER = '<%= @cron_user %>'
