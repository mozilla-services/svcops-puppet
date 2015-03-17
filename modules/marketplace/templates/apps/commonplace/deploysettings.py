CLUSTER = '<%= cluster %>'
DOMAIN = '<%= domain %>'
ENV = '<%= env %>'
SSH_KEY = '<%= ssh_key %>'
PROJECT_NAME = '<%= @project_name %>'
<% if @zamboni_dir -%>
ZAMBONI_DIR = '<%= @zamboni_dir %>'
<% else -%>
ZAMBONI_DIR = None
<% end -%>
