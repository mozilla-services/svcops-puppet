CLUSTER = '<%= @cluster %>'
APPNAME = '<%= app_name %>'
DOMAIN = '<%= @domain %>'
ENV = '<%= @env %>'
SSH_KEY = '<%= @ssh_key %>'
PYREPO = '<%= @pyrepo %>'
UPDATE_REF = <% if update_ref %>'<%= @update_ref %>'<% else %>None<% end %>
UWSGI = filter(None, '<%= @uwsgi %>'.split(';'))
