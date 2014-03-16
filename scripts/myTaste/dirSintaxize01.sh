#!/bin/bash
#
# Moves files by:
# Setting all to lower case
# Quitting spaces and adding Capital Letter to Word after spaces
#

ls -d * | while read entrada; 
do
  salida_tmp=$(/home/sarroutbi/bin/strings/toLower.sh "$entrada")
  salida=$(/home/sarroutbi/bin/strings/noSpacesAndUpper.sh "$salida_tmp")
  if [ "$salida" != "$entrada" ];
  then  
    mv "$entrada" "$salida";
  fi
done
