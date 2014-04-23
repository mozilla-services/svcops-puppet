# Manage sysctl settings on all hosts
class base::sysctl::all {

  sysctl::value {
    'vm.swappiness':
      value => '10';
  }
}
