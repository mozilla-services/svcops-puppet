CLUSTER = '<%= cluster %>'
DOMAIN = '<%= domain %>'
ENV = '<%= env %>'
SSH_KEY = '<%= ssh_key %>'
PYREPO = '<%= pyrepo %>'
CRON_NAME = '<%= cron_name %>'
GUNICORN = filter(None, '<%= gunicorn %>'.split(';'))
UWSGI = filter(None, '<%= uwsgi %>'.split(';'))
MULTI_GUNICORN = filter(None, '<%= multi_gunicorn %>'.split(';'))
CELERY_SERVICE = '<%= celery_service %>'
UPDATE_REF = <% if update_ref %>'<%= update_ref %>'<% else %>None<% end %>
<% if @scl_name -%>
SCL_NAME = '<%= scl_name %>'
<% end -%>
