#!/bin/bash
# https://bugzilla.mozilla.org/show_bug.cgi?id=956335
# http://support.citrix.com/proddocs/topic/ns-security-10-map/ns-aaa-users-and-groups-tsk.html

set -u
set -e

BACKUPUSER='nsbackup'
BACKUPDIR='/var/lib/nsbackup'
DATE=$(/bin/date +'%Y%m%d%H%M')
NSHOSTS=('10.32.8.10' '10.32.8.11')

source ~/.ns/pass

# because of netscaler sadness use expect
autopassword () {
expect << EOF
set timeout 120
spawn $1
expect {
    "Password:" {
    send {$PASS}
    send "\r"
    }
    default {}
}
expect eof
EOF
}

if [ ! -d $BACKUPDIR ]; then
  mkdir -p $BACKUPDIR
fi

# connect to first netscaler host and run create backup
autopassword "ssh $BACKUPUSER@${NSHOSTS[0]} \"create system backup backup.$DATE -level basic\""

for host in "${NSHOSTS[@]}"
do
  if [ ! -d $BACKUPDIR/$host ]; then
    mkdir -p $BACKUPDIR/$host
  fi
  autopassword "scp $BACKUPUSER@$host:/var/ns_sys_backup/backup.$DATE.tgz $BACKUPDIR/$host/"
  pushd $BACKUPDIR/$host
  tar xzf backup.$DATE.tgz
  rm -f backup.$DATE.tgz
  popd
done

cd $BACKUPDIR
git add *
git commit -m "Netscaler Backup $DATE"

# connect to first netscaler host and remove backup
autopassword "ssh $BACKUPUSER@${NSHOSTS[0]} \"rm system backup backup.$DATE.tgz\""
