#!/bin/bash
#
# Moves files by:
# Quitting spaces and adding Capital Letter to Word after spaces
#

ls -d * | while read entrada; 
do
  salida=$(/home/sarroutbi/bin/strings/noSpacesAndUpper.sh "$entrada")
  if [ "$salida" != "$entrada" ];
  then  
    mv "$entrada" "$salida";
  fi
done
