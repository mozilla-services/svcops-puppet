# Bug 894522
class marketplace::utils::sync_packaged_apps(
  $aws_access_key = '',
  $aws_secret_key = '',
  $bucket = 'marketplace.packagedapps',
  $file_prefix = '/mnt/netapp/marketplace.prod/addons.mozilla.org',
  $zamboni = '/data/mkt.prod/www/marketplace.firefox.com/current/zamboni',
) {

  file { '/root/bin/sync_packaged_apps':
    content => template('marketplace/utils/sync_packaged_apps.py'),
    mode    => '0700',
  }->
  cron {
    'sync_packaged_apps-public':
      command => "cd ${zamboni}; ../venv/bin/python manage.py --settings=settings_local_mkt list_packaged_apps --status=public | /root/bin/sync_packaged_apps public > /dev/null",
      minute  => '7';

    'sync_packaged_apps-pending':
      command => "cd ${zamboni}; ../venv/bin/python manage.py --settings=settings_local_mkt list_packaged_apps --status=pending | /root/bin/sync_packaged_apps pending > /dev/null",
      minute  => '14';

    'sync_packaged_apps-approved':
      command => "cd ${zamboni}; ../venv/bin/python manage.py --settings=settings_local_mkt list_packaged_apps --status=approved | /root/bin/sync_packaged_apps approved > /dev/null",
      minute  => '21';

    'sync_packaged_apps-rejected':
      command => "cd ${zamboni}; ../venv/bin/python manage.py --settings=settings_local_mkt list_packaged_apps --status=rejected | /root/bin/sync_packaged_apps rejected > /dev/null",
      minute  => '7';
}
