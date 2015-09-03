# define celery service.
define celery::service (
  $app_dir,
  $args = '',
  $command = undef,
  $environ = '',
  $log_level = 'INFO',
  $project = undef,
  $python = '/usr/bin/python',
  $scl = undef,
  $stopwaitsecs = '300',
  $user = 'celery',
  $workers = '4',
) {
  include supervisord::base

  if $user == 'celery' {
    include celery::user
  }

  if $command == 'celeryworker' {
    $celery_command = "${python} ${app_dir}/manage.py celery worker --loglevel=${log_level} -c ${workers} ${args}"
  }
  elsif $command == 'standalone' {
    $celery_command = "${python} ${app_dir}/../venv/bin/celery -A ${project} worker -E --loglevel=${log_level} -c ${workers} ${args}"
  }
  elsif $command {
    $celery_command = $command
  }
  else {
    $celery_command = "${python} ${app_dir}/manage.py celeryd --loglevel=${log_level} -c ${workers} ${args}"
  }

  if $scl {
    $extra_environ = "LD_LIBRARY_PATH=/opt/rh/${scl}/root/usr/lib64,PATH=/opt/rh/${scl}/root/usr/bin:/sbin:/usr/sbin:/bin:/usr/bin"
  } else {
    $extra_environ = ''
  }

  $real_environ = join(reject([$environ, $extra_environ], '^$'), ',')

  $celery_name = $name

  supervisord::service {
    "celeryd-${celery_name}":
      command      => $celery_command,
      app_dir      => $app_dir,
      environ      => $real_environ,
      stopwaitsecs => $stopwaitsecs,
      user         => $user,
  }
}
