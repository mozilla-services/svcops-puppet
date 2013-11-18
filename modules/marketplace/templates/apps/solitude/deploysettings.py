CLUSTER = '<%= cluster %>'
DOMAIN = '<%= domain %>'
ENV = '<%= env %>'
SSH_KEY = '<%= ssh_key %>'
CRON_NAME = '<%= cron_name %>'
CRON_USER = '<%= cron_user %>'
UWSGI = filter(None, '<%= uwsgi %>'.split(';'))
PYREPO = '<%= pyrepo %>'
IS_PROXY = <%= is_proxy ? 'True' : 'False' %>
WEB_ROLE = '<%= web_role %>'
<% if @scl_name -%>
SCL_NAME = '<%= scl_name %>'
<% end -%>
