exports.config = {
    name: '<%= @instance_description %>',
    default_url: '<%= @default_url %>',
    env: '<%= @env %>',
    data_root: '<%= @data_root %>',
    htpasswd_file: '<%= @root %>/htpasswd',
    secure: <%= @secure %>,
    login_required: true,
    unauthorized_read: true,
    stacks: {
