# this is a temp fix for hive related data bug 1059965
class marketplace::apps::olympia::hive(
  $dirpath
) {
  cron {
    'fix-hive-perms':
      command => "chmod -R g+w ${dirpath}",
      user    => 'root',
      hour    => '8',
      minute  => '0',
  }
}
