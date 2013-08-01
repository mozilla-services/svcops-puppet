CLUSTER = '<%= cluster %>'
DOMAIN = '<%= domain %>'
ENV = '<%= env %>'
SSH_KEY = '<%= ssh_key %>'
CRON_NAME = '<%= cron_name %>'
CRON_USER = '<%= cron_user %>'
UWSGI = filter(None, '<%= uwsgi %>'.split(';'))
PYREPO = '<%= pyrepo %>'
IS_PROXY = <%= is_proxy ? 'True' : 'False' %>
