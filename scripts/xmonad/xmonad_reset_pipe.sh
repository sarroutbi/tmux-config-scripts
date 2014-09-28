#!/bin/bash
#
MODE_LOOP=0
if [ "$1" = "1" ];
then
  MODE_LOOP=1
fi
pid=$(pidof xmonad-x86_64-linux)
echo "PID:${pid}"

while true;
do
  pipe=$(ls -1 /proc/${pid}/fd/ | sort -n | tail -1)
  cat /proc/${pid}/fd/${pipe} &
  pid_cat=$(pidof cat)
  sleep 1
  test -z "${pid_cat}" && kill -9 ${pid_cat} 2>/dev/null 1>/dev/null 
  if [ $MODE_LOOP -eq 0 ];
  then
    break;
  fi
  sleep 1
  killall -9 cat
done
