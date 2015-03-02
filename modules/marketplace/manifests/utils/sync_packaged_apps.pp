# Bug 894522
class marketplace::utils::sync_packaged_apps(
  $aws_access_key = '',
  $aws_secret_key = '',
  $bucket = 'marketplace.packagedapps',
  $file_prefix = '/mnt/netapp/marketplace.prod/addons.mozilla.org',
  $zamboni = '/data/mkt.prod/www/marketplace.firefox.com/current/zamboni',
) {

  $cron_prefix = "source /opt/rh/python27/enable && cd ${zamboni} && DJANGO_SETTINGS_MODULE=settings_local_mkt ../venv/bin/python manage.py list_packaged_apps"

  file { '/root/bin/sync_packaged_apps':
    content => template('marketplace/utils/sync_packaged_apps.py'),
    mode    => '0700',
  }->
  cron {
    'sync_packaged_apps-public':
      command => "${cron_prefix} --status=public | /root/bin/sync_packaged_apps public > /dev/null",
      minute  => '7';

    'sync_packaged_apps-pending':
      command => "${cron_prefix} --status=pending | /root/bin/sync_packaged_apps pending > /dev/null",
      minute  => '14';

    'sync_packaged_apps-approved':
      command => "${cron_prefix} --status=approved | /root/bin/sync_packaged_apps approved > /dev/null",
      minute  => '21';

    'sync_packaged_apps-rejected':
      command => "${cron_prefix} --status=rejected | /root/bin/sync_packaged_apps rejected > /dev/null",
      minute  => '28';
  }
}
