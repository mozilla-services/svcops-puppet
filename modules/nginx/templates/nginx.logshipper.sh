#!/bin/bash

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

DOMAINS=(addons.mozilla.org marketplace.firefox.com)
PRE_DATE=$(date +%Y-%m-%d --date="yesterday")
CUR_DATE=$(date +%Y%m%d)
LOG_DIR="/var/log/nginx/"
LOG_HOST="<%= log_host %>"
LOG_HOST_USER="<%= log_host_user %>"
LOG_HOST_KEY="<%= log_host_key %>"
RESULT_LOG_DIR="/var/log/nginx/logshipper"

if [ ! -d $RESULT_LOG_DIR ]
then
    mkdir $RESULT_LOG_DIR
fi

RESULTLOG="$RESULT_LOG_DIR/$CUR_DATE"

#rename logs
for domain in "${DOMAINS[@]}"
do
    cd $LOG_DIR/$domain
    if [ -f metrics.log-$CUR_DATE ]
    then
        mv metrics.log-$CUR_DATE $PRE_DATE.log
    fi
done

#compress files
find $LOG_DIR -type f -name "$PRE_DATE.log" ! -name '*.gz' -print0 | xargs -0 -r -n 1 -P 4 nice -n 10 gzip

#ship files
rsync -av --ignore-existing  --include='addons.mozilla.org' --include='marketplace.firefox.com' --include="$PRE_DATE.log.gz" --exclude="*" -e "ssh -o StrictHostKeyChecking=no -i $LOG_HOST_KEY" $LOG_DIR/ $LOG_HOST_USER@$LOG_HOST:/data/stats/logs/$HOSTNAME/  &> $RESULTLOG
