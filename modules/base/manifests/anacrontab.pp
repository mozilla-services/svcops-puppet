# manage anacrontab file
class base::anacrontab {
  file {
    '/etc/anacrontab':
      ensure  => present,
      content => template('base/etc/anacrontab'),
      mode    => '0644'
  }
}
