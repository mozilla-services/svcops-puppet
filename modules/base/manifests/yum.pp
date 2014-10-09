# audit
class base::yum {
  case $::operatingsystemrelease {
    /^6/: {
      include base::yum::rhel6
    }
    /^7/: {
      include base::yum::rhel7
    }
    default: { }
  }
}
