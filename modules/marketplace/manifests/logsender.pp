# A send logs to a list of hosts.
class marketplace::logsender(
  $loghosts = []
){
  rsyslog::udpnode {
    $loghosts:;
  }
}
