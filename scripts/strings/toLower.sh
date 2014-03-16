#!/bin/bash

function toLower_usage()
{
  echo ""
  echo "toLower.sh usage:"
  echo ""
  echo "toLower.sh \"letter\""
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

echo $1 | tr '[A-Z]' '[a-z]'
