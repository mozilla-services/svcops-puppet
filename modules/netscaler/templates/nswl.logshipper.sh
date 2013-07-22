#!/bin/bash

HOSTNAME=$(hostname -f)
CUR_DATE=$(date +%Y-%m-%d-%H)
LOG_DIR=/data/netscaler/logs
LOG_HOST="<%= log_host %>"
LOG_HOST_USER="<%= log_host_user %>"
LOG_HOST_KEY="<%= log_host_key %>"

if [ ! -d /var/log/nswllogshipper ]
then
    mkdir /var/log/nswllogshipper
fi

RESULTLOG="/var/log/nswllogshipper/$CUR_DATE"

find $LOG_DIR/*/ -type f -name '*.log*' ! -name '*.gz' ! -name "$CUR_DATE.log*" -print0 | xargs -0 -r -n 1 -P 4 nice -n 10 gzip

rsync -av --ignore-existing --include='*/' --include='*.gz' --exclude='*' --remove-source-files -e "ssh -o StrictHostKeyChecking=no -i $LOG_HOST_KEY" $LOG_DIR/ $LOG_HOST_USER@$LOG_HOST:/data/stats/logs/$HOSTNAME/ &> $RESULTLOG
