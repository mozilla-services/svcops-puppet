CLUSTER = '<%= @cluster %>'
DOMAIN = '<%= @domain %>'
ENV = '<%= @env %>'
SSH_KEY = '<%= @ssh_key %>'
PROJECT_NAME = '<%= @project_name %>'
PYREPO = '<%= @pyrepo %>'
DATA_PATH = '<%= @data_path %>'
UWSGI = filter(None, '<%= @uwsgi %>'.split(';'))
<% if @scl_name -%>
SCL_NAME = '<%= scl_name %>'
<% end -%>
