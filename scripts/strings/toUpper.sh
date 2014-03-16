#!/bin/bash

function toUpper_usage()
{
  echo ""
  echo "toUpper.sh usage:"
  echo ""
  echo "toUpper.sh \"letter\""
  echo ""
}

if [ $# -ne 1 ];
then
  toUpper_usage 
  exit 1 
fi

length=$(echo -n $# | wc -c)
if [ $length -ne 1 ];
then
  toUpper_usage 
  exit 1 
fi

echo $1 | tr '[a-z]' '[A-Z]'
