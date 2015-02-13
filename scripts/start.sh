#!/bin/bash -ex

#GET ALL INFO FROM /mnt/external/source.info:
#source /mnt/external/source.info

/sbin/cron.sh &
/sbin/sshd.sh &

while true;
  do
  sleep 60;
  date;
done

