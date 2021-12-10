#!/bin/bash
DEFAULT_SLEEP_TIME=3600
recheck_time=${DEFAULT_SLEEP_TIME}
log_file="/tmp/check_upsc.log"

while true;
do
        charge=$(upsc apc-700 | awk -F "battery.charge:" '{print $2}')
        echo "CHARGE:${charge}"
        sendemail -f from@mail.com -t to@mail.com -s smtp.gmail.com:587 -u "Subject" -m "Message"  -v -xu user -xp password -o tls=yes -v 2>&1 | tee "${log_file}"
        res=$?
        sleep "${recheck_time}"
done
