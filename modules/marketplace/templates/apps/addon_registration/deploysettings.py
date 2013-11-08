CLUSTER = '<%= @cluster %>'
DOMAIN = '<%= @domain %>'
ENV = '<%= @env %>'
SSH_KEY = '<%= @ssh_key %>'
PYREPO = '<%= @pyrepo %>'
UWSGI = filter(None, '<%= @uwsgi %>'.split(';'))
CELERY_SERVICE = '<%= @celery_service %>'
UPDATE_REF = <% if update_ref %>'<%= @update_ref %>'<% else %>None<% end %>
