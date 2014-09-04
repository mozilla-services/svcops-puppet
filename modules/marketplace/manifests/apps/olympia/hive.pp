# this is a temp fix for hive related data bug 1059965
class marketplace::apps::olympia::hive(
  $dirpath
) {
  cron {
    'fix-hive-perms':
      command => "/bin/chmod -R g+w ${dirpath} > /dev/null 2>&1",
      user    => 'root',
      hour    => '8',
      minute  => '0',
  }
}
