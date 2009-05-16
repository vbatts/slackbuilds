#!/bin/sh

if [ $UID != 0 ] ; then 
  echo please be root
  exit 1
fi

if [ -f /etc/slackware-mirror.conf ] ; then
  . /etc/slackware-mirror.conf
else
  echo "No config found"
  exit 1
fi

for _source in $SLACKWARE_VERSIONS ; do
  RSYNC_SOURCE=${SLACKWARE_RSYNC_SOURCE}slackware-${_source}/
  RSYNC_DEST=${SLACKWARE_RSYNC_DEST}slackware-${_source}/

  echo RSYNC_SOURCE $RSYNC_SOURCE
  echo RSYNC_DEST $RSYNC_DEST

  date

  rsync -avPHS --exclude '*pasture/*' \
    --exclude '*/kdei/*' \
    --exclude '*/source/*' \
    --exclude '*/testing/*' \
    --delete-after \
    $RSYNC_SOURCE $RSYNC_DEST
done
